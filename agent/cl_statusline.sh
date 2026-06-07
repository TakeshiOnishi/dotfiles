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

# Line 1: model, absolute path, agent
AGENT_PART=""
[ -n "$AGENT" ] && AGENT_PART=" | agent:$AGENT"
echo "[$MODEL] $DIR${AGENT_PART}"

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

