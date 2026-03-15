# 🤖 Telegram Bot Tester

*Русский | [English](README.md)*

Скилл для Claude Code — **сквозное тестирование** Telegram-ботов через автоматизацию браузера.

Взаимодействует через Telegram Web — отправляет команды, нажимает инлайн-кнопки, читает ответы — затем сверяет результаты с базой данных и логами. Работает с любым языком, фреймворком, БД и способом деплоя.

### 🎬 Демо

https://github.com/kr1ke/tg-bot-tester-skill/raw/main/tg-test-skill.mp4

## ✨ Возможности

- 🔍 **Автоматическое обнаружение** — читает код бота, находит все команды, обработчики и ожидаемое поведение
- 🌐 **Тестирование в реальном браузере** — взаимодействует через Telegram Web как живой пользователь
- 🗄️ **Проверка данных** — сверяет ответы бота с фактическими записями в базе данных
- 📋 **Анализ логов** — находит необработанные исключения, ошибки API и предупреждения
- 📊 **Структурированные отчёты** — выдаёт понятный вердикт с багами и рекомендациями
- 🔒 **Только чтение** — никогда не изменяет код, данные или конфигурацию

## 📦 Требования

- [Claude Code](https://docs.anthropic.com/en/docs/claude-code)
- Расширение [Claude in Chrome](https://chromewebstore.google.com/detail/claude-in-chrome/oibcadmpfbjdadkgelajoccihcpfnglf)
- Открытый и авторизованный Telegram Web

## 🚀 Примеры использования

Можно вызвать через слэш-команду:

```
/telegram-bot-tester                       # Полный тест бота в проекте
/telegram-bot-tester @MyQuizBot            # Тест конкретного бота по юзернейму
/telegram-bot-tester /start                # Тест только команды /start
/telegram-bot-tester expired callbacks     # Тест конкретного сценария
```

Или просто описать задачу словами:

```
"протестируй моего телеграм-бота"
"проверь, отвечает ли бот на /start правильно"
"сделай QA бота end-to-end"
"проверь поведение бота после последних изменений"
```

## 📥 Установка

<details>
<summary><b>На уровне проекта</b> (только этот проект)</summary>

```bash
git clone https://github.com/kr1ke/tg-bot-tester-skill.git /tmp/tg-bot-tester-skill
mkdir -p .claude/skills/telegram-bot-tester
cp -r /tmp/tg-bot-tester-skill/skill/* .claude/skills/telegram-bot-tester/
rm -rf /tmp/tg-bot-tester-skill
```

</details>

<details>
<summary><b>Глобально</b> (доступен во всех проектах)</summary>

```bash
git clone https://github.com/kr1ke/tg-bot-tester-skill.git /tmp/tg-bot-tester-skill
mkdir -p ~/.claude/skills/telegram-bot-tester
cp -r /tmp/tg-bot-tester-skill/skill/* ~/.claude/skills/telegram-bot-tester/
rm -rf /tmp/tg-bot-tester-skill
```

</details>

Итоговая структура:

```
.claude/skills/telegram-bot-tester/
├── SKILL.md
├── references/
│   └── telegram-web-interaction.md
└── scripts/
    └── validate_query.sh
```

## ⚙️ Как это работает

| Фаза | Описание |
|------|----------|
| 1. Разведка | Читает код бота, находит команды, обработчики, БД и ожидаемое поведение |
| 2. Проверка окружения | Убеждается, что процесс бота и БД запущены |
| 3. Браузерное взаимодействие | Открывает бота в Telegram Web, отправляет команды, кликает кнопки |
| 4. Верификация данных | Сверяет ответы из UI с фактическими записями в БД |
| 5. Анализ логов | Ищет исключения, ошибки API и предупреждения |
| 6. Отчёт | Выдаёт структурированный вердикт с находками и рекомендациями |

## 🛠️ Поддерживаемые стеки

| Слой | Поддержка |
|------|-----------|
| Язык | Node.js, Python, Go, Ruby и др. |
| Фреймворк | grammY, Telegraf, aiogram, python-telegram-bot, telebot и др. |
| Хранилище | PostgreSQL, MongoDB, Redis, SQLite, без БД |
| Деплой | Docker, PM2, systemd, обычный процесс, serverless |

## 🔒 Работает без доступа к бэкенду

Нет доступа к базе данных или логам? Скилл не сломается — он пропустит фазы верификации данных и анализа логов, и сфокусируется на браузерном тестировании: отправка команд, клики по кнопкам, визуальная проверка ответов.
