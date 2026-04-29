/**
 * Safe read-only commands that never require approval.
 *
 * Commands in SAFE_COMMANDS are allowed unconditionally.
 * Commands in SAFE_SUBCOMMANDS are only allowed with listed subcommands.
 */

// Always safe regardless of arguments (read-only by nature)
export const SAFE_COMMANDS: string[] = [
	// File reading
	"cat",
	"head",
	"tail",
	"less",
	"more",
	"wc",
	"file",
	"stat",
	"bat",

	// Search
	"find",
	"grep",
	"rg",
	"fd",
	"ag",
	"fgrep",
	"egrep",

	// Directory listing / disk info
	"ls",
	"tree",
	"du",
	"df",
	"pwd",

	// Path utilities
	"basename",
	"dirname",
	"realpath",
	"readlink",

	// System info
	"which",
	"whereis",
	"whoami",
	"uname",
	"date",
	"hostname",
	"id",
	"uptime",

	// Output / display
	"echo",
	"printf",
	"env",
	"printenv",

	// Text processing (read-only, no -i)
	"sort",
	"uniq",
	"cut",
	"tr",
	"awk",
	"diff",
	"comm",
	"tee",
	"jq",
	"yq",
	"xargs",

	// Test / check
	"test",
	"true",
	"false",
	"[",
];

// Commands that are only safe with specific subcommands
export const SAFE_SUBCOMMANDS: Record<string, string[]> = {
	git: [
		"status",
		"log",
		"diff",
		"branch",
		"remote",
		"show",
		"tag",
		"ls-files",
		"rev-parse",
		"describe",
		"shortlog",
		"blame",
		"reflog",
		"stash list",
		"config --get",
		"config --list",
	],
	docker: ["ps", "images", "logs", "inspect", "stats", "top", "port", "version", "info"],
	npm: ["list", "ls", "view", "info", "outdated", "audit", "explain", "why", "pack --dry-run"],
	yarn: ["list", "info", "why", "outdated"],
	pnpm: ["list", "ls", "why", "outdated"],
	cargo: ["check", "clippy", "tree", "metadata", "verify-project"],
	go: ["list", "vet", "doc", "version", "env"],
	pip: ["list", "show", "check", "freeze"],
	brew: ["list", "info", "search", "outdated", "deps"],
	kubectl: ["get", "describe", "logs", "top", "version", "config view"],
	az: ["version", "account show"],
	gcloud: ["version", "config list", "info"],
};
