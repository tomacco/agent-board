# Changelog

## 0.1.0 (2026-10-15)

First release as its own project, split from Agents Mission Control.

- Menu bar pill with three tiles: hands off, caffeinate, and projects serving on localhost.
- Hands-off enforcement in two layers: the `boardd` LaunchAgent and a Claude Code `PreToolUse` hook.
- `uninstall.sh` removes the app, its LaunchAgents, the hook and `~/.agent-board`.
- Tests: `tests/test-hands-off.sh` (18 checks).
