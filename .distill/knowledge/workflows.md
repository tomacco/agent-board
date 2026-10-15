---
domain: workflows
scope: build, install, test, preview, release
last_validated: 2026-10-15
staleness_threshold: 60
---

# Workflows

- `./build.sh` → `build/AgentBoard.app` (Developer ID when available, ad hoc otherwise). evidence: build.sh
  confidence: validated
- `./install.sh` (idempotent): build, copy to `~/Applications`, (re)load both LaunchAgents, register the hook (`CLAUDE_CONFIG_DIR` picks another config). `./uninstall.sh` removes all of it. evidence: install.sh, uninstall.sh
  confidence: validated
- [IMPORTANT] install.sh does not restart a running app: quit it and `open -a ~/Applications/AgentBoard.app`. evidence: install.sh
  confidence: validated
- `zsh tests/test-hands-off.sh` (18 checks, private flag, safe anytime). evidence: tests/test-hands-off.sh
  confidence: validated
- Preview: `build/AgentBoard.app/Contents/MacOS/AgentBoard --preview` prints a window number for `screencapture -o -l <n>`. evidence: Bar.swift
  confidence: validated
- Release: bump `CFBundleShortVersionString` in build.sh, add a CHANGELOG.md entry, tag `vX.Y.Z`, GitHub release. evidence: CHANGELOG.md
  confidence: provisional
  origin: convention
- Knowledge: `bash scripts/check-freshness.sh` (pre-commit and CI); after editing `.distill/`, run `bash scripts/render-adapters.sh`. evidence: scripts/
  confidence: hardened
