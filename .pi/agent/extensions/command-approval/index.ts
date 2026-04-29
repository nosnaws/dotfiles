/**
 * Command Approval Extension
 *
 * Gates bash, write, and edit tool calls behind an approval prompt.
 *
 * Bash commands:
 *   - Safe read-only commands are always allowed (see defaults.ts)
 *   - Persistent rules can be created from the approval prompt
 *   - Rules support exact match, "<cmd> <subcmd> *", and "<cmd> *" patterns
 *
 * Write/Edit:
 *   - Require per-call approval by default
 *   - Shift+Tab toggles auto-allow edits mode for the session
 *
 * /approve command to list, add, remove, or clear rules.
 */

import type { ExtensionAPI, ExtensionContext } from "@mariozechner/pi-coding-agent";
import { isToolCallEventType } from "@mariozechner/pi-coding-agent";
import { Text } from "@mariozechner/pi-tui";
import { SAFE_COMMANDS, SAFE_SUBCOMMANDS } from "./defaults.ts";
import { loadRules, saveRules, addRule, removeRule, parseCommand, matchesRule, type ApprovalRule } from "./rules.ts";

export default function (pi: ExtensionAPI) {
	let rules: ApprovalRule[] = loadRules();
	let autoAllowEdits = false;

	// ── Status ──────────────────────────────────────────────────────────

	function updateStatus(ctx: ExtensionContext) {
		if (autoAllowEdits) {
			ctx.ui.setWidget("cmd-approval-edit-mode", (_tui, theme) =>
				new Text(theme.fg("warning", "⚡"), 0, 0),
			);
		} else {
			ctx.ui.setWidget("cmd-approval-edit-mode", undefined);
		}
	}

	// ── Shortcuts ───────────────────────────────────────────────────────

	pi.registerShortcut("ctrl+shift+e", {
		description: "Toggle auto-allow edits",
		handler: async (ctx) => {
			autoAllowEdits = !autoAllowEdits;
			ctx.ui.notify(autoAllowEdits ? "Edits: auto-allow ✓" : "Edits: require approval ✓", "info");
			updateStatus(ctx);
		},
	});

	// ── Session lifecycle ───────────────────────────────────────────────

	pi.on("session_start", async (_event, ctx) => {
		rules = loadRules();
		autoAllowEdits = false;
		updateStatus(ctx);
	});

	// ── Safe command check ──────────────────────────────────────────────

	function isSafeCommand(binary: string, subcommand: string | undefined): boolean {
		if (SAFE_COMMANDS.includes(binary)) return true;
		if (subcommand && SAFE_SUBCOMMANDS[binary]?.includes(subcommand)) return true;
		return false;
	}

	// ── Tool call gate ──────────────────────────────────────────────────

	pi.on("tool_call", async (event, ctx) => {
		if (!ctx.hasUI) {
			// Non-interactive: block everything that isn't safe
			if (isToolCallEventType("bash", event)) {
				const parsed = parseCommand(event.input.command);
				if (isSafeCommand(parsed.binary, parsed.subcommand)) return undefined;
				if (matchesRule(parsed, rules)) return undefined;
			}
			return { block: true, reason: "No UI available for command approval" };
		}

		// ── Bash ────────────────────────────────────────────────────────

		if (isToolCallEventType("bash", event)) {
			const command = event.input.command;
			const parsed = parseCommand(command);

			// Safe read-only → allow silently
			if (isSafeCommand(parsed.binary, parsed.subcommand)) return undefined;

			// Matches a persistent rule → allow silently
			if (matchesRule(parsed, rules)) return undefined;

			// Build context-aware options
			const options: string[] = ["Allow once", "Deny"];

			if (parsed.subcommand) {
				options.push(`Always allow: ${parsed.binary} ${parsed.subcommand} *`);
			}
			options.push(`Always allow: ${parsed.binary} *`);

			const choice = await ctx.ui.select(`⚠️  ${command}`, options);

			if (!choice || choice === "Deny") {
				ctx.abort();
				return { block: true, reason: "Denied by user" };
			}

			if (choice === "Allow once") return undefined;

			// "Always allow: <pattern>"
			const pattern = choice.replace("Always allow: ", "");
			rules = addRule(rules, pattern);
			ctx.ui.notify(`Rule saved: ${pattern}`, "info");
			updateStatus(ctx);
			return undefined;
		}

		// ── Write / Edit ────────────────────────────────────────────────

		if (event.toolName === "write" || event.toolName === "edit") {
			if (autoAllowEdits) return undefined;

			const path = (event.input as { path?: string }).path ?? "unknown";
			const verb = event.toolName === "write" ? "Write" : "Edit";

			const choice = await ctx.ui.select(`✏️  ${verb}: ${path}`, ["Allow", "Deny", "Auto-allow edits"]);

			if (!choice || choice === "Deny") {
				ctx.abort();
				return { block: true, reason: "Denied by user" };
			}

			if (choice === "Auto-allow edits") {
				autoAllowEdits = true;
				updateStatus(ctx);
			}
			return undefined;
		}

		return undefined;
	});

	// ── /approve command ────────────────────────────────────────────────

	pi.registerCommand("approve", {
		description: "Manage command approval rules",
		getArgumentCompletions: (prefix: string) => {
			const subcommands = ["list", "clear", "add ", "remove "];
			if (!prefix) {
				return subcommands.map((s) => ({ value: s, label: s.trim() }));
			}

			// If typing "remove ...", complete with existing rule patterns
			if (prefix.startsWith("remove ")) {
				const partial = prefix.slice(7);
				const items = rules
					.filter((r) => r.pattern.startsWith(partial))
					.map((r) => ({ value: `remove ${r.pattern}`, label: r.pattern }));
				return items.length > 0 ? items : null;
			}

			const filtered = subcommands
				.filter((s) => s.startsWith(prefix))
				.map((s) => ({ value: s, label: s.trim() }));
			return filtered.length > 0 ? filtered : null;
		},
		handler: async (args, ctx) => {
			const trimmed = (args ?? "").trim();

			if (!trimmed || trimmed === "list") {
				if (rules.length === 0) {
					ctx.ui.notify("No custom approval rules.", "info");
					return;
				}
				const lines = rules.map((r) => `  ✓ ${r.pattern}`).join("\n");
				ctx.ui.notify(`Approval rules (${rules.length}):\n${lines}`, "info");
				return;
			}

			if (trimmed === "clear") {
				const ok = await ctx.ui.confirm("Clear rules?", `Remove all ${rules.length} approval rules?`);
				if (!ok) return;
				rules = [];
				saveRules(rules);
				ctx.ui.notify("All rules cleared.", "info");
				updateStatus(ctx);
				return;
			}

			if (trimmed.startsWith("remove ")) {
				const pattern = trimmed.slice(7).trim();
				if (!rules.some((r) => r.pattern === pattern)) {
					ctx.ui.notify(`Rule not found: ${pattern}`, "warning");
					return;
				}
				rules = removeRule(rules, pattern);
				ctx.ui.notify(`Removed: ${pattern}`, "info");
				updateStatus(ctx);
				return;
			}

			if (trimmed.startsWith("add ")) {
				const pattern = trimmed.slice(4).trim();
				if (!pattern) {
					ctx.ui.notify("Usage: /approve add <pattern>", "warning");
					return;
				}
				rules = addRule(rules, pattern);
				ctx.ui.notify(`Added: ${pattern}`, "info");
				updateStatus(ctx);
				return;
			}

			ctx.ui.notify(
				"Usage: /approve [list | clear | add <pattern> | remove <pattern>]\n\n" +
					"Patterns:\n" +
					'  git *           — allow all git commands\n' +
					'  git commit *    — allow git commit with any args\n' +
					'  npm install     — allow exact command',
				"info",
			);
		},
	});
}
