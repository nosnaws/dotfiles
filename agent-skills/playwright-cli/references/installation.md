# Installation & Setup

## Requirements

- Node.js 18+

## Install

```bash
npm install -g @playwright/cli@latest
```

Verify:

```bash
playwright-cli --version
playwright-cli --help
```

## Install Browser (if needed)

```bash
playwright-cli install-browser
```

This installs the bundled Chromium. Use `--browser=chrome` to use your system Chrome instead.

## Configuration

### Config File

Create `playwright-cli.json` in your project root (auto-detected) or specify with `--config`:

```json
{
  "browser": {
    "browserName": "chromium",
    "launchOptions": {
      "headless": true
    }
  },
  "capabilities": {
    "actionTimeout": 5000,
    "navigationTimeout": 60000
  }
}
```

Apply config to a running session:

```bash
playwright-cli config --config path/to/config.json
```

### Environment Variables

All prefixed with `PLAYWRIGHT_MCP_`:

| Variable | Purpose | Default |
|----------|---------|---------|
| `BROWSER` | Browser type | chromium |
| `HEADLESS` | Headless mode | true |
| `TIMEOUT_ACTION` | Action timeout (ms) | 5000 |
| `TIMEOUT_NAVIGATION` | Navigation timeout (ms) | 60000 |
| `ALLOWED_ORIGINS` | Whitelist origins | (none) |
| `BLOCKED_ORIGINS` | Block origins | (none) |
| `OUTPUT_DIR` | Screenshot/PDF output dir | (cwd) |
| `SAVE_VIDEO` | Record video | false |
| `SAVE_TRACE` | Record trace | false |
| `ISOLATED` | Isolated browser context | false |

Example:

```bash
PLAYWRIGHT_MCP_BROWSER=chrome PLAYWRIGHT_MCP_HEADLESS=false playwright-cli open https://example.com
```

### Default Session

Set `PLAYWRIGHT_CLI_SESSION` to avoid passing `--session` each time:

```bash
export PLAYWRIGHT_CLI_SESSION=myapp
playwright-cli open https://myapp.com   # Uses "myapp" session automatically
```
