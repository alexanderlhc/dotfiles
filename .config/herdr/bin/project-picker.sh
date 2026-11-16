#!/usr/bin/env bash
# prefix+f — fzf picker over open workspaces, herdr worktrees and ~/code repos.
# Enter focuses the workspace if one is already open for that path; otherwise
# opens the worktree / creates a workspace for the repo.
set -euo pipefail

CODE_DIR=${PROJECT_PICKER_ROOT:-$HOME/code}
DEPTH=${PROJECT_PICKER_DEPTH:-4}

c_dim=$'\e[2m' c_off=$'\e[0m' c_ws=$'\e[32m' c_wt=$'\e[35m' c_repo=$'\e[34m'
tilde() { printf %s "${1/#$HOME/\~}"; }

# Rows: display \t kind \t path \t workspace_id \t repo_root
rows() {
  local ws_json; ws_json=$(herdr workspace list 2>/dev/null || echo '{}')

  # 1. Open workspaces (current one excluded)
  jq -r --arg cur "${HERDR_WORKSPACE_ID:-}" '
    .result.workspaces[]? | select(.workspace_id != $cur)
    | [.label, .agent_status, (.worktree.checkout_path // ""), .workspace_id]
    | join("\u001f")' <<<"$ws_json" |
  while IFS=$'\x1f' read -r label status path id; do
    printf '%s %-32s %s%-8s %s%s\tws\t%s\t%s\t\n' \
      "${c_ws}●${c_off}" "$label" "$c_dim" "$status" "$(tilde "$path")" "$c_off" "$path" "$id"
  done

  local open_paths; open_paths=$(jq -r '.result.workspaces[]?.worktree.checkout_path // empty' <<<"$ws_json")

  # Repos under CODE_DIR, ordered by zoxide frecency, then the rest alphabetically
  local repos; repos=$(fd -H -t d '^\.git$' "$CODE_DIR" --max-depth "$DEPTH" -x dirname {} | sort)
  local ordered
  ordered=$( { zoxide query -l 2>/dev/null | grep -Fxf <(echo "$repos") || true; echo "$repos"; } | awk '!seen[$0]++')

  # 2. Linked worktrees not open
  while IFS= read -r repo; do
    git -C "$repo" worktree list --porcelain 2>/dev/null | awk '
      /^worktree /{p=substr($0,10)} /^branch /{b=substr($0,8); sub("refs/heads/","",b)}
      /^$/{if(p!="") print p "\t" b; p=""; b=""} END{if(p!="") print p "\t" b}' | tail -n +2 |
    while IFS=$'\t' read -r path branch; do
      [[ $'\n'$open_paths$'\n' == *$'\n'$path$'\n'* ]] && continue
      [ -d "$path" ] || continue
      printf '%s %-32s %s%-8s %s%s\twt\t%s\t\t%s\n' \
        "${c_wt}⎇${c_off}" "${repo##*/}/${branch:-${path##*/}}" "$c_dim" "worktree" "$(tilde "$path")" "$c_off" "$path" "$repo"
    done
  done <<<"$repos"

  # 3. Repos not open
  while IFS= read -r repo; do
    [[ $'\n'$open_paths$'\n' == *$'\n'$repo$'\n'* ]] && continue
    printf '%s %-32s %s%-8s %s%s\trepo\t%s\t\t\n' \
      "${c_repo}○${c_off}" "${repo##*/}" "$c_dim" "" "$(tilde "${repo%/*}")" "$c_off" "$repo"
  done <<<"$ordered"
}

preview='p={3}; [ -n "$p" ] && [ -d "$p" ] || { echo "(no path)"; exit; }
echo -e "\e[1m$p\e[0m"; git -C "$p" -c color.status=always status -sb 2>/dev/null | head -15; echo
git -C "$p" log --oneline --color -12 2>/dev/null'

sel=$(rows | fzf --with-shell='bash -c' --ansi --delimiter=$'\t' --with-nth=1 --nth=1 \
  --layout=reverse --height=100% --border=none --info=inline \
  --prompt='project> ' --header='● open  ⎇ worktree  ○ repo' \
  --preview="$preview" --preview-window='right,45%,border-left,<90(down,40%,border-top)') || exit 0

IFS=$'\x1f' read -r _ kind path id repo <<<"${sel//$'\t'/$'\x1f'}"
case $kind in
  ws)   herdr workspace focus "$id" >/dev/null ;;
  wt)   herdr worktree open --cwd "$repo" --path "$path" --focus >/dev/null ;;
  repo) herdr workspace create --cwd "$path" --label "$(basename "$path")" --focus >/dev/null ;;
esac
