---
domain: architecture
scope: components, entrypoints, state locations
last_validated: 2026-10-15
staleness_threshold: 90
---

# Architecture

## Components
- **Menu bar app** (SwiftPM executable `AgentBoard`, bundle `co.tomac.agentboard`, LSUIElement). evidence: Package.swift, build.sh
  - `AgentBoardApp.swift`: entry and the `Board` observable model (polls the flag, caffeinate, servers).
  - `Bar.swift`: the one NSStatusItem pill and its pixel art; `Panel.swift`: the glass panel tiles.
- **Scripts** in `bin/`: `boardctl` (flip hands off), `boardd` (enforcer loop), `servers` (localhost listeners as TSV). evidence: bin/
- **Claude Code hook** `hooks/hands-off-guard.sh` (PreToolUse on Bash). evidence: install.sh
- **LaunchAgents** `launchd/*.plist`, templated with `@ROOT@`/`@HOME@` by install.sh. evidence: install.sh
- `swiftbar/`: the original SwiftBar plugins; the caffeinate tile still calls `swiftbar/caffeinate/caffeinate.5s.sh`. evidence: AgentBoardApp.swift#caffeinate
  confidence: validated

## Data flow: hands off
- The panel and `boardctl` only write or remove `~/.agent-board/hands-off`; `boardd` and the hook enforce. [IMPORTANT] Keep enforcement out of the UI.
  evidence: README.md, AGENTS.md
  confidence: validated
  origin: directive
- Other tools read the flag (Agents Mission Control stays silent while it exists). evidence: README.md
  confidence: validated

## State on disk
- `~/.agent-board/hands-off`; logs `~/Library/Logs/boardd.log`. Info.plist key `BoardRoot` points the app at the checkout (scripts run live from the repo). evidence: build.sh, AgentBoardApp.swift
  confidence: validated
