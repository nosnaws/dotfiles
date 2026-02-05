---
name: playwright-cli
description: Automate browser interactions via the Playwright CLI. Use for web testing, form filling, screenshots, UI verification, and data extraction.
---

# Browser Automation with playwright-cli

## When to Use

- Navigate and interact with web pages (click, type, fill forms)
- Take screenshots for UI debugging or to verify UI features
- Test web application behavior end-to-end
- Extract data from rendered pages
- Manage browser sessions and storage state

## Core Workflow

1. **Open** a URL: `playwright-cli open https://example.com`
2. **Snapshot** to get element refs: `playwright-cli snapshot`
3. **Interact** using refs: `playwright-cli click e3`, `playwright-cli fill e5 "text"`
4. **Verify** with screenshot or re-snapshot: `playwright-cli screenshot`

## Essential Commands

```bash
playwright-cli open [url]             # Navigate to URL
playwright-cli snapshot               # Get element refs (eN identifiers)
playwright-cli click <ref>            # Click element
playwright-cli fill <ref> <text>      # Fill input field
playwright-cli type <text>            # Type into focused element
playwright-cli screenshot [ref]       # Capture page or element screenshot
playwright-cli select <ref> <value>   # Select dropdown option
playwright-cli press <key>            # Press keyboard key
playwright-cli eval <js> [ref]        # Run JS on page or element
```

## Screenshots for UI Debugging

Use `playwright-cli screenshot` after interactions to visually verify the page state. Target specific elements with `playwright-cli screenshot e5`. Screenshots save to the output directory as PNG files.

## Sessions

```bash
playwright-cli --session=myapp open https://app.com   # Named session
playwright-cli --session=myapp snapshot                # Reuse session
playwright-cli session-list                            # List active sessions
playwright-cli session-stop myapp                      # Stop session
```

Sessions persist browser state (cookies, storage, login) across commands.

## Options

| Flag | Purpose |
|------|---------|
| `--browser <name>` | chrome, firefox, webkit, msedge |
| `--headed` | Show browser window |
| `--session <name>` | Named persistent session |
| `--config <path>` | Custom config file |
| `--in-memory` | No disk persistence |

## References

- [Installation & setup](references/installation.md)
- [Advanced usage & full command reference](references/advanced-usage.md)
