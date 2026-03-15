# 🤖 Telegram Bot Tester

*[Русский](README.ru.md) | English*

Claude Code skill for **end-to-end testing** Telegram bots via browser automation.

Interacts through Telegram Web — sends commands, clicks inline buttons, reads responses — then verifies against data stores and logs. Stack-agnostic: works with any language, framework, database, and deployment method.

https://github.com/user-attachments/assets/PLACEHOLDER_VIDEO

## ✨ Features

- 🔍 **Auto-discovery** — reads your code to find all commands, handlers, and expected behavior
- 🌐 **Real browser testing** — interacts through Telegram Web exactly like a human user
- 🗄️ **Data verification** — cross-references UI responses with actual data store records
- 📋 **Log analysis** — catches unhandled exceptions, API errors, and warnings
- 📊 **Structured reports** — outputs a clear verdict with bugs and recommendations
- 🔒 **Read-only** — never modifies your code, data, or configuration

## 📦 Requirements

- [Claude Code](https://docs.anthropic.com/en/docs/claude-code)
- [Claude in Chrome](https://chromewebstore.google.com/detail/claude-in-chrome/oibcadmpfbjdadkgelajoccihcpfnglf) extension
- Telegram Web open and logged in

## 🚀 Use Cases

You can invoke the skill using the slash command:

```
/telegram-bot-tester                       # Full test of the bot in your project
/telegram-bot-tester @MyQuizBot            # Test a specific bot by username
/telegram-bot-tester /start                # Test only the /start command flow
/telegram-bot-tester expired callbacks     # Test a specific scenario
```

Or just describe what you need in natural language:

```
"test my telegram bot"
"check if the bot responds to /start correctly"
"QA the bot end-to-end"
"verify bot behavior after the last changes"
```

## ⚙️ How It Works

| Phase | Description |
|-------|-------------|
| 1. Reconnaissance | Reads bot code to map commands, handlers, data store, and expected behavior |
| 2. Environment Check | Verifies the bot process and data store are running |
| 3. Browser Interaction | Opens the bot in Telegram Web, sends commands, clicks buttons |
| 4. Data Verification | Cross-references UI responses with actual DB/store records |
| 5. Log Analysis | Checks for exceptions, API errors, and warnings |
| 6. Test Report | Outputs a structured verdict with findings and recommendations |

## 🛠️ Supported Stacks

| Layer | Supported |
|-------|-----------|
| Language | Node.js, Python, Go, Ruby, etc. |
| Framework | grammY, Telegraf, aiogram, python-telegram-bot, telebot, etc. |
| Data Store | PostgreSQL, MongoDB, Redis, SQLite, none |
| Deployment | Docker, PM2, systemd, bare process, serverless |

## 📥 Installation

<details>
<summary><b>Claude Code</b></summary>

Copy the `skill/` folder contents into your project's skills directory:

```bash
# Clone the repo
git clone https://github.com/kr1ke/tg-bot-tester-skill.git /tmp/tg-bot-tester-skill

# Copy to your project (project-level skill)
mkdir -p .claude/skills/telegram-bot-tester
cp -r /tmp/tg-bot-tester-skill/skill/* .claude/skills/telegram-bot-tester/

# Or install globally (available in all projects)
mkdir -p ~/.claude/skills/telegram-bot-tester
cp -r /tmp/tg-bot-tester-skill/skill/* ~/.claude/skills/telegram-bot-tester/

# Clean up
rm -rf /tmp/tg-bot-tester-skill
```

Resulting structure:

```
.claude/skills/telegram-bot-tester/
├── SKILL.md
├── references/
│   └── telegram-web-interaction.md
└── scripts/
    └── validate_query.sh
```

</details>

<details>
<summary><b>Cursor</b></summary>

Cursor uses `.cursor/rules/` for custom instructions:

```bash
git clone https://github.com/kr1ke/tg-bot-tester-skill.git /tmp/tg-bot-tester-skill

mkdir -p .cursor/rules
cp /tmp/tg-bot-tester-skill/skill/SKILL.md .cursor/rules/telegram-bot-tester.md

rm -rf /tmp/tg-bot-tester-skill
```

> Note: Cursor does not support multi-file skills with references. The main SKILL.md will work, but references won't be auto-loaded.

</details>

<details>
<summary><b>Windsurf</b></summary>

Windsurf uses `.windsurf/rules/` or `AGENTS.md`:

```bash
git clone https://github.com/kr1ke/tg-bot-tester-skill.git /tmp/tg-bot-tester-skill

mkdir -p .windsurf/rules
cp /tmp/tg-bot-tester-skill/skill/SKILL.md .windsurf/rules/telegram-bot-tester.md

rm -rf /tmp/tg-bot-tester-skill
```

</details>

<details>
<summary><b>Cline</b></summary>

Cline uses `.clinerules` or extension settings:

```bash
git clone https://github.com/kr1ke/tg-bot-tester-skill.git /tmp/tg-bot-tester-skill

# Copy the SKILL.md content into .clinerules or paste into
# Cline extension settings → Custom Instructions
cat /tmp/tg-bot-tester-skill/skill/SKILL.md >> .clinerules

rm -rf /tmp/tg-bot-tester-skill
```

</details>

## 📄 License

MIT
