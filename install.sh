#!/bin/zsh
# Install Agent Board on this Mac: build the app, run the enforcer and the app at login, and register the
# Claude Code hook. Idempotent. CLAUDE_CONFIG_DIR picks another Claude Code config folder.
set -e
cd "${0:A:h}"; ROOT=$PWD
CLAUDE_DIR=${CLAUDE_CONFIG_DIR:-$HOME/.claude}
./build.sh
mkdir -p ~/Applications && rm -rf ~/Applications/AgentBoard.app && cp -R build/AgentBoard.app ~/Applications/
LA=~/Library/LaunchAgents
for name in boardd app; do
  plist=$LA/co.tomac.agentboard.$name.plist
  sed "s|@ROOT@|$ROOT|g; s|@HOME@|$HOME|g" launchd/co.tomac.agentboard.$name.plist > $plist
  launchctl bootout gui/$(id -u) $plist 2>/dev/null || true
  launchctl bootstrap gui/$(id -u) $plist
done
mkdir -p "$CLAUDE_DIR"; [[ -f $CLAUDE_DIR/settings.json ]] || print "{}" > "$CLAUDE_DIR/settings.json"
python3 - "$ROOT/hooks/hands-off-guard.sh" "$CLAUDE_DIR/settings.json" <<'PY'
import json, sys
hook, p = sys.argv[1], sys.argv[2]
s = json.load(open(p))
pre = s.setdefault("hooks", {}).setdefault("PreToolUse", [])
if not any(h.get("command") == hook for e in pre for h in e.get("hooks", [])):
    pre.append({"matcher": "Bash", "hooks": [{"type": "command", "command": hook, "timeout": 5,
                "statusMessage": "Agent Board: hands-off guard"}]})
    json.dump(s, open(p, "w"), indent=2); open(p, "a").write("\n")
    print("hook registered")
PY
echo "Agent Board installed. Proof: zsh tests/test-hands-off.sh"
