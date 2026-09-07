#!/bin/bash
input=$(cat)

export CLAUDE_MODEL=$(echo "$input" | jq -r '.model.display_name // "?"')
export CLAUDE_SESSION=$(echo "$input" | jq -r '.session_name // empty // .session_id[:8]')
export CLAUDE_CONTEXT=$(printf '%s%%' "$(echo "$input" | jq -r '.context_window.used_percentage // 0' | cut -d. -f1)")
raw_tokens=$(echo "$input" | jq -r '.context_window.current_usage.input_tokens // empty')
if [ -n "$raw_tokens" ] && [ "$raw_tokens" -ge 1000 ] 2>/dev/null; then
  export CLAUDE_TOKENS=$(awk "BEGIN { printf \"%.1fk tkns\", $raw_tokens/1000 }")
elif [ -n "$raw_tokens" ]; then
  export CLAUDE_TOKENS="${raw_tokens} tkns"
else
  export CLAUDE_TOKENS=""
fi

STARSHIP_SHELL= starship prompt
