#!/usr/bin/env bash
# prefix+p — today's plan in nvim, with a claude pane beside it.
#   plan exists  -> claude reads it and waits for instructions
#   plan missing -> claude runs /daily-plan to build it, and nvim opens the
#                   file as soon as the skill writes it
set -euo pipefail

PLANS_DIR="${PLANS_DIR:-$HOME/plans}"
today=$(date +%F)
plan="$PLANS_DIR/$today.md"
mkdir -p "$PLANS_DIR"

ws_args=()
if [ -n "${HERDR_WORKSPACE_ID:-}" ]; then
  ws_args=(--workspace "$HERDR_WORKSPACE_ID")
fi

# Already open? Focus it rather than starting a second /daily-plan.
label="plan $today"
existing=$(herdr tab list "${ws_args[@]}" 2>/dev/null \
  | jq -r --arg l "$label" '.result.tabs[] | select(.label == $l) | .tab_id' | head -1)
if [ -n "${existing:-}" ]; then
  herdr tab focus "$existing" >/dev/null 2>&1 && exit 0
fi

tab=$(herdr tab create "${ws_args[@]}" --cwd "$PLANS_DIR" --label "$label" --focus)
left=$(jq -r '.result.root_pane.pane_id' <<<"$tab")
right=$(herdr pane split "$left" --direction right --ratio 0.5 --no-focus \
          --cwd "$PLANS_DIR" | jq -r '.result.pane.pane_id')

if [ -f "$plan" ]; then
  herdr pane run "$left" "nvim $(printf '%q' "$plan")"
  prompt="Read $plan in full, then wait for my instructions. Do nothing else."
  focus_from="$right"; focus_dir="left"
else
  # /daily-plan interviews first, so hand it the focus; open nvim on the file
  # the moment the skill writes it.
  prompt="/daily-plan"
  focus_from="$left"; focus_dir="right"
  (
    for _ in $(seq 1 1800); do
      if [ -f "$plan" ]; then
        sleep 1
        herdr pane run "$left" "nvim $(printf '%q' "$plan")" || true
        exit 0
      fi
      sleep 2
    done
  ) >/dev/null 2>&1 &
  disown 2>/dev/null || true
fi

# claude can flicker through a "blocked" state while starting (trust/theme
# dialogs), which makes `agent start` report agent_not_ready even though the
# agent comes up fine. Don't let that abort the script.
herdr agent start "plan-$today" --kind claude --pane "$right" \
  --timeout 60000 >/dev/null 2>&1 || true

if herdr agent wait "$right" --until idle --timeout 60000 >/dev/null 2>&1; then
  herdr agent prompt "$right" "$prompt" >/dev/null
fi

herdr pane focus --pane "$focus_from" --direction "$focus_dir" >/dev/null 2>&1 || true
