# Telegram Bot Tester

Claude Code skill for end-to-end testing Telegram bots via browser automation.

Interacts through Telegram Web — sends commands, clicks inline buttons, reads responses — then verifies against data stores and logs. Stack-agnostic: works with any language, framework, database, and deployment method.

## Requirements

- [Claude Code](https://docs.anthropic.com/en/docs/claude-code)
- [Claude in Chrome](https://chromewebstore.google.com/detail/claude-in-chrome/oibcadmpfbjdadkgelajoccihcpfnglf) extension
- Telegram Web open and logged in

## Use Cases

```
# Full bot test — discovers commands, runs all flows, verifies data
/telegram-bot-tester

# Test a specific bot by username
/telegram-bot-tester @MyQuizBot

# Test a single command flow
/telegram-bot-tester /start

# Test a specific scenario
/telegram-bot-tester expired callbacks
```

## What It Does

1. **Reconnaissance** — reads your bot's code to understand commands, handlers, data store, and expected behavior
2. **Environment check** — verifies the bot process and data store are running (Docker, PM2, systemd, etc.)
3. **Browser interaction** — opens the bot in Telegram Web, sends commands, clicks buttons, reads responses
4. **Data verification** — cross-references UI responses with actual data store records
5. **Log analysis** — checks for unhandled exceptions, API errors, and warnings
6. **Test report** — outputs a structured verdict with findings and recommendations

## Supported Stacks

| Layer | Supported |
|-------|-----------|
| Language | Node.js, Python, Go, Ruby, etc. |
| Framework | grammY, Telegraf, aiogram, python-telegram-bot, telebot, etc. |
| Data store | PostgreSQL, MongoDB, Redis, SQLite, none |
| Deployment | Docker, PM2, systemd, bare process, serverless |

## Installation

Copy the skill into your project:

```
.claude/skills/telegram-bot-tester/
├── SKILL.md
├── evals/
│   └── evals.json
├── references/
│   └── telegram-web-interaction.md
└── scripts/
    └── validate_query.sh
```

## Read-Only Policy

This skill never modifies your code, data store, or bot configuration. All interactions are read-only — it only observes and reports.
