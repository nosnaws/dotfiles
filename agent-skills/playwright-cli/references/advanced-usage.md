# Advanced Usage

Run `playwright-cli --help` or `playwright-cli --help <command>` for full command reference.

## Workflows

### Form Submission

```bash
playwright-cli open https://app.com/login
playwright-cli snapshot                       # Find element refs (eN)
playwright-cli fill e3 "user@example.com"
playwright-cli fill e5 "password123"
playwright-cli click e7
playwright-cli screenshot                     # Verify result
```

### Authenticated Session Reuse

```bash
# Login once, save state
playwright-cli --session=myapp open https://app.com/login
# ... fill login form ...
playwright-cli --session=myapp state-save auth-state.json

# Restore in future sessions
playwright-cli state-load auth-state.json
playwright-cli open https://app.com/dashboard
```

### UI Verification with Screenshots

```bash
playwright-cli open http://localhost:3000
playwright-cli screenshot                     # Full page
playwright-cli screenshot e12                 # Specific element
```

### Debugging

```bash
playwright-cli console                        # Check JS errors
playwright-cli network                        # Inspect API calls
playwright-cli eval "document.title"          # Query DOM
```

### Network Mocking

```bash
playwright-cli route "https://api.example.com/users" \
  --body '{"users": []}' --status 200
playwright-cli route-list
playwright-cli unroute "https://api.example.com/users"
```
