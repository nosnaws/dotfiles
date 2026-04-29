/**
 * Rule engine for command approval.
 *
 * Rules are persisted to ~/.pi/agent/command-approval-rules.json
 * and loaded on session start.
 */

import { readFileSync, writeFileSync, mkdirSync } from "node:fs";
import { join, dirname } from "node:path";
import { homedir } from "node:os";

export interface ApprovalRule {
	pattern: string;
	action: "allow";
	createdAt: number;
}

export interface ParsedCommand {
	raw: string;
	binary: string;
	subcommand: string | undefined;
}

const CONFIG_PATH = join(homedir(), ".pi", "agent", "command-approval-rules.json");

export function loadRules(): ApprovalRule[] {
	try {
		const data = readFileSync(CONFIG_PATH, "utf-8");
		return JSON.parse(data);
	} catch {
		return [];
	}
}

export function saveRules(rules: ApprovalRule[]): void {
	mkdirSync(dirname(CONFIG_PATH), { recursive: true });
	writeFileSync(CONFIG_PATH, JSON.stringify(rules, null, 2));
}

export function addRule(rules: ApprovalRule[], pattern: string): ApprovalRule[] {
	if (rules.some((r) => r.pattern === pattern)) return rules;
	const updated = [...rules, { pattern, action: "allow" as const, createdAt: Date.now() }];
	saveRules(updated);
	return updated;
}

export function removeRule(rules: ApprovalRule[], pattern: string): ApprovalRule[] {
	const updated = rules.filter((r) => r.pattern !== pattern);
	saveRules(updated);
	return updated;
}

/**
 * Parse a bash command string into binary + optional subcommand.
 *
 * Handles:
 * - Leading env vars: `FOO=bar command ...`
 * - sudo prefix: `sudo command ...`
 * - Multiline: uses first line
 * - Pipes/chains: uses the first command segment
 */
export function parseCommand(command: string): ParsedCommand {
	const trimmed = command.trim();

	// Take first line
	let line = trimmed.split("\n")[0].trim();

	// Take first command in a chain (before &&, ||, ;, |)
	line = line.split(/\s*(?:&&|\|\||[;|])\s*/)[0].trim();

	// Strip leading variable assignments: VAR=val VAR2=val command
	line = line.replace(/^(?:\w+=\S*\s+)+/, "");

	// Strip sudo
	if (line.startsWith("sudo ")) {
		line = line.slice(5).trim();
	}

	const parts = line.split(/\s+/);
	const binary = parts[0] || trimmed;

	// Second part as subcommand if it doesn't start with -
	const subcommand = parts[1] && !parts[1].startsWith("-") ? parts[1] : undefined;

	return { raw: command, binary, subcommand };
}

/**
 * Check if a parsed command matches any approval rule.
 *
 * Match priority:
 * 1. Exact match against raw command
 * 2. "<binary> <subcommand> *" wildcard
 * 3. "<binary> *" wildcard
 */
export function matchesRule(parsed: ParsedCommand, rules: ApprovalRule[]): boolean {
	for (const rule of rules) {
		// Exact match
		if (rule.pattern === parsed.raw) return true;

		// Subcmd wildcard: "git commit *"
		if (parsed.subcommand && rule.pattern === `${parsed.binary} ${parsed.subcommand} *`) return true;

		// Cmd wildcard: "git *"
		if (rule.pattern === `${parsed.binary} *`) return true;
	}
	return false;
}
