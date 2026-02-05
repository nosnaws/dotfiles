#!/bin/zsh

DOTFILES_DIR="$(cd "$(dirname "$0")" && pwd)"

# Helper function to confirm overwrite
confirm_overwrite() {
    local target="$1"
    if [[ -e "$target" && ! -L "$target" ]]; then
        echo "File already exists: $target"
        read -q "REPLY?Overwrite? (y/n) "
        echo
        [[ "$REPLY" == "y" ]]
    else
        return 0  # Symlinks or non-existent files: proceed without asking
    fi
}

# Create target directories
mkdir -p ~/.claude/skills
mkdir -p ~/.codex/skills

# Symlink AGENTS_TEMPLATE.md to Claude Code
if confirm_overwrite ~/.claude/CLAUDE.md; then
    ln -sf "$DOTFILES_DIR/AGENTS_TEMPLATE.md" ~/.claude/CLAUDE.md
    echo "Linked: ~/.claude/CLAUDE.md"
fi

# Symlink AGENTS_TEMPLATE.md to Codex CLI
if confirm_overwrite ~/.codex/AGENTS.md; then
    ln -sf "$DOTFILES_DIR/AGENTS_TEMPLATE.md" ~/.codex/AGENTS.md
    echo "Linked: ~/.codex/AGENTS.md"
fi

# Symlink each skill directory to both CLIs
for skill_dir in "$DOTFILES_DIR/agent-skills"/*/; do
    skill_name=$(basename "$skill_dir")
    ln -sf "$skill_dir" ~/.claude/skills/"$skill_name"
    ln -sf "$skill_dir" ~/.codex/skills/"$skill_name"
    echo "Linked skill: $skill_name"
done
