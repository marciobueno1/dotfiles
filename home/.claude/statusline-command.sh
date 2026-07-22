#!/bin/sh
# Claude Code status line
# Shows: model name | context window used % | 5h usage % | 7d usage %

input=$(cat)

model=$(echo "$input" | jq -r '.model.display_name')

ctx_used=$(echo "$input" | jq -r '.context_window.used_percentage // empty')
five_hour=$(echo "$input" | jq -r '.rate_limits.five_hour.used_percentage // empty')
seven_day=$(echo "$input" | jq -r '.rate_limits.seven_day.used_percentage // empty')

out="$model"

if [ -n "$ctx_used" ]; then
  out=$(printf "%s | ctx: %.0f%%" "$out" "$ctx_used")
fi

if [ -n "$five_hour" ]; then
  out=$(printf "%s | 5h: %.0f%%" "$out" "$five_hour")
fi

if [ -n "$seven_day" ]; then
  out=$(printf "%s | 7d: %.0f%%" "$out" "$seven_day")
fi

printf "%s" "$out"
