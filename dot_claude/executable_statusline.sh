#!/bin/bash
input=$(cat)

MODEL=$(echo "$input" | jq -r '.model.display_name')
PCT=$(echo "$input" | jq -r '.context_window.used_percentage // 0' | cut -d. -f1)
COST=$(echo "$input" | jq -r '.cost.total_cost_usd // 0')
DIR=$(echo "$input" | jq -r '.workspace.current_dir')
AGENT=$(echo "$input" | jq -r '.agent.name // empty')
FIVE_H=$(echo "$input" | jq -r '.rate_limits.five_hour.used_percentage // empty')
SEVEN_D=$(echo "$input" | jq -r '.rate_limits.seven_day.used_percentage // empty')

# Build a progress bar from a percentage value
make_bar() {
  local pct=$1
  local width=10
  local filled=$((pct * width / 100))
  local empty=$((width - filled))
  local bar=""
  [ "$filled" -gt 0 ] && printf -v f "%${filled}s" && bar="${f// /▓}"
  [ "$empty" -gt 0 ] && printf -v e "%${empty}s" && bar="${bar}${e// /░}"
  echo "$bar"
}

CTX_BAR=$(make_bar "$PCT")
COST_FMT=$(printf '$%.4f' "$COST")

# Git info: branch, worktree state, last commit, ahead/behind (empty outside a repo)
git_info() {
  local dir=$1
  [ -n "$dir" ] && [ -d "$dir" ] || return 0
  local st
  st=$(git --no-optional-locks -C "$dir" status --porcelain=v2 --branch 2>/dev/null) || return 0
  [ -n "$st" ] || return 0

  # Parse branch header and file counts in one pass
  local parsed
  parsed=$(echo "$st" | awk '
    /^# branch.oid /  { oid=$3 }
    /^# branch.head / { head=$3 }
    /^# branch.ab /   { ab="↑" substr($3,2) " ↓" substr($4,2) }
    /^[12u] /         { x=substr($2,1,1); y=substr($2,2,1)
                        if (x != ".") s++
                        if (y != ".") u++ }
    /^\? /            { t++ }
    END {
      if (head == "(detached)") head = substr(oid,1,7)
      printf "%s\t%d\t%d\t%d\t%s\n", head, s, u, t, ab
    }')
  local branch s u t ab
  IFS=$'\t' read -r branch s u t ab <<< "$parsed"

  local state
  if [ "$s" -eq 0 ] && [ "$u" -eq 0 ] && [ "$t" -eq 0 ]; then
    state="✓"
  else
    state=""
    [ "$s" -gt 0 ] && state="+$s"
    [ "$u" -gt 0 ] && state="${state:+$state }~$u"
    [ "$t" -gt 0 ] && state="${state:+$state }?$t"
  fi

  # Last commit subject cut to 30 chars (UTF-8 aware)
  local commit="" subj
  subj=$(git --no-optional-locks -C "$dir" log -1 --format=%s 2>/dev/null)
  if [ -n "$subj" ]; then
    local old_lc=${LC_ALL-}
    export LC_ALL=en_US.UTF-8
    if [ "${#subj}" -gt 30 ]; then subj="${subj:0:30}…"; fi
    if [ -n "$old_lc" ]; then export LC_ALL=$old_lc; else unset LC_ALL; fi
    commit=" · $subj"
  fi

  local out="⎇ $branch $state${commit}"
  [ -n "$ab" ] && out="$out $ab"
  echo "$out"
}

GIT_PART=$(git_info "$DIR")
[ -n "$GIT_PART" ] && GIT_PART=" | $GIT_PART"

# Line 1: model, absolute path, git, agent
AGENT_PART=""
[ -n "$AGENT" ] && AGENT_PART=" | agent:$AGENT"
echo "[$MODEL] $DIR${GIT_PART}${AGENT_PART}"

# Line 2: context gauge, cost, rate limit gauges
RATE_PART=""
if [ -n "$FIVE_H" ]; then
  FIVE_H_INT=$(printf '%.0f' "$FIVE_H")
  FIVE_H_BAR=$(make_bar "$FIVE_H_INT")
  RATE_PART=" | 5h $FIVE_H_BAR ${FIVE_H_INT}%"
fi
if [ -n "$SEVEN_D" ]; then
  SEVEN_D_INT=$(printf '%.0f' "$SEVEN_D")
  SEVEN_D_BAR=$(make_bar "$SEVEN_D_INT")
  RATE_PART="${RATE_PART} | 7d $SEVEN_D_BAR ${SEVEN_D_INT}%"
fi

echo "ctx $CTX_BAR ${PCT}% | $COST_FMT${RATE_PART}"

