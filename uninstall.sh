#!/bin/zsh
# Remove Agent Board from this Mac: the app, both LaunchAgents, the Claude Code hook and ~/.agent-board.
cd "${0:A:h}"; ROOT=$PWD
CLAUDE_DIR=${CLAUDE_CONFIG_DIR:-$HOME/.claude}
for name in boardd app; do
  launchctl bootout gui/$(id -u) ~/Library/LaunchAgents/co.tomac.agentboard.$name.plist 2>/dev/null
  rm -f ~/Library/LaunchAgents/co.tomac.agentboard.$name.plist
done
osascript -e 'quit app id "co.tomac.agentboard"' 2>/dev/null
pkill -f "AgentBoard.app/Contents/MacOS/" 2>/dev/null
rm -rf ~/Applications/AgentBoard.app ~/.agent-board
[[ -f $CLAUDE_DIR/settings.json ]] && python3 - "$ROOT/hooks/hands-off-guard.sh" "$CLAUDE_DIR/settings.json" <<'PY'
import json, sys
hook, p = sys.argv[1], sys.argv[2]
s = json.load(open(p)); n = 0
for e in s.get("hooks", {}).get("PreToolUse", []):
    keep = [h for h in e.get("hooks", []) if not h.get("command", "").endswith(hook)]
    n += len(e.get("hooks", [])) - len(keep); e["hooks"] = keep
if "hooks" in s: s["hooks"]["PreToolUse"] = [e for e in s["hooks"].get("PreToolUse", []) if e.get("hooks")]
json.dump(s, open(p, "w"), indent=2); open(p, "a").write("\n")
print(f"hook entries removed: {n}")
PY
print "Agent Board removed."
