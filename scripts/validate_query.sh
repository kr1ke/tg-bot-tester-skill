#!/bin/bash
# Blocks write operations across common data store CLIs.
# Called as PreToolUse hook before every Bash tool invocation.
# Exit 0 = allow, Exit 2 = block (stderr shown to Claude)

INPUT=$(cat)
COMMAND=$(echo "$INPUT" | jq -r '.tool_input.command // empty')

[ -z "$COMMAND" ] && exit 0

# --- PostgreSQL / MySQL / SQLite ---
if echo "$COMMAND" | grep -qE 'psql|mysql|sqlite3'; then
  if echo "$COMMAND" | grep -iE '\b(INSERT|UPDATE|DELETE|DROP|CREATE|ALTER|TRUNCATE|GRANT|REVOKE)\b' > /dev/null; then
    echo "BLOCKED: SQL write operation detected. This skill is read-only." >&2
    exit 2
  fi
fi

# --- MongoDB ---
if echo "$COMMAND" | grep -qE 'mongosh|mongo '; then
  if echo "$COMMAND" | grep -iE '\.(insert|update|delete|drop|remove|save|replaceOne|bulkWrite|createIndex|renameCollection)' > /dev/null; then
    echo "BLOCKED: MongoDB write operation detected. This skill is read-only." >&2
    exit 2
  fi
fi

# --- Redis ---
if echo "$COMMAND" | grep -q 'redis-cli'; then
  if echo "$COMMAND" | grep -iE '\b(SET|DEL|FLUSHDB|FLUSHALL|HSET|HDEL|LPUSH|RPUSH|SADD|SREM|ZADD|ZREM|EXPIRE|RENAME|MOVE)\b' > /dev/null; then
    echo "BLOCKED: Redis write operation detected. This skill is read-only." >&2
    exit 2
  fi
fi

exit 0
