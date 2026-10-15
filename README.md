# Agent Board

A macOS menu bar pill for working next to local coding agents: a hands-off switch that silences agents, a caffeinate control, and the projects serving on localhost.

Version 0.1.0. macOS 26 or later, Apple Silicon. MIT license. By Ivan Gonzalez (tomacco) · [tomac.co](https://tomac.co)

| Part | What it shows |
|---|---|
| Clawd | Orange with sound waves: agents may talk. Red with a pause sign: hands off, so no agent may speak, play sounds or drive the mouse and keyboard. |
| Cup | Faded when off; colored with time left (or ∞) when awake; amber when the screen is kept on too. |
| Rack | Number of projects serving on localhost. The panel lists them; click a port to open it, right-click to stop it. |

Click Clawd to toggle hands off, anywhere else on the pill for the panel, right-click to quit.

## Install

```sh
git clone https://github.com/tomacco/agent-board.git
cd agent-board
./install.sh   # builds the app into ~/Applications, loads both LaunchAgents, registers the hands-off hook
```

Remove it with `./uninstall.sh`. The app needs no special macOS permissions.

## Hands off

The panel only writes or removes `~/.agent-board/hands-off`. Two independent layers act on that flag:

1. `bin/boardd` (LaunchAgent `co.tomac.agentboard.boardd`) kills `say`, `afplay`, `uidriver` and `cliclick` within 0.25 s, for any process, Claude Code or not. Kills are logged to `~/Library/Logs/boardd.log`.
2. `hooks/hands-off-guard.sh` (Claude Code `PreToolUse` on Bash) refuses those commands and tells the agent to carry on headless, so agents do not retry in a loop.

From a shell: `bin/boardctl on | off | toggle | status`. Other tools can read the flag: [Agents Mission Control](https://github.com/tomacco/agents-mission-control) stays silent while it exists.

Known gap: a program that posts mouse events under a name outside the block list is not stopped. The fix is an event tap in the app that drops synthetic input while the flag is on, tracked in the backlog.

## Tests

`tests/test-hands-off.sh` runs against a private flag, so it never touches the live switch: a running driver dies, new speech dies before it is heard, the hook blocks voice, sound and input commands, ordinary commands still pass, and turning the switch off gives control back.

## Development

- `build/AgentBoard.app/Contents/MacOS/AgentBoard --preview` opens the pill and panel in a window for 6 s and prints its window number, for `screencapture -o -l <n>` without clicking the menu bar.
- `swiftbar/` holds the original SwiftBar plugins. The caffeinate tile calls `swiftbar/caffeinate/caffeinate.5s.sh start|stop`, so runs started from either place are recognised.

Agent Board started inside Agents Mission Control and became its own project in October 2026.
