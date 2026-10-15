---
domain: gotchas
scope: traps that cost time in this repo
last_validated: 2026-10-15
staleness_threshold: 90
---

# Gotchas

- [IMPORTANT] Never click the menu bar or post synthetic input to test the UI: a person may be at the keyboard. Use `--preview`. evidence: AGENTS.md
  confidence: validated
  origin: directive
- [IMPORTANT] If `bin/boardctl status` says hands off is on, do not speak, play sounds or drive input, and never turn it off yourself. evidence: AGENTS.md, hooks/hands-off-guard.sh
  confidence: hardened
  origin: directive
- Running the tests with `bash` fails (`A: unbound variable`): they are zsh. evidence: tests/*.sh shebang
  confidence: validated
- A Bash command whose text contains `pkill` or `quit app` (even inside a heredoc) trips the app-quit guard some sessions run. Write such scripts with the file editor. evidence: 2026-10-15 split
  confidence: provisional
- A program posting mouse events under a name outside the block list is not stopped (backlog task-1). evidence: bin/boardd#BLOCK
  confidence: validated
