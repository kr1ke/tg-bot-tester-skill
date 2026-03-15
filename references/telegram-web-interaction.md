# Telegram Web Interaction via Claude Chrome Extension

This reference covers how to interact with Telegram Web (`web.telegram.org/a/`) using the Claude Chrome Extension's browser tools. The Chrome Extension connects Claude Code to the user's real Chrome browser — Telegram Web is already open and the user is already logged in.

---

## 1. Verifying the Connection

Before any browser interaction, confirm the Chrome Extension is connected.

**If browser tools fail or return errors:**
- Suggest the user run `/chrome` in Claude Code to check status and reconnect
- If the error says "Browser extension is not connected" or "Extension not detected", the user needs to:
  1. Check Chrome is running with the extension enabled
  2. Run `/chrome` → "Reconnect extension"
  3. If first time: restart Chrome to pick up the native messaging host config

**Once connected**, the browser tools work on whatever tabs the user has open.

---

## 2. Finding and Opening the Bot Chat

There are three scenarios for finding the bot:
- **Username known** (from `$ARGUMENTS` or `getMe`) — search for it in Telegram Web
- **No username, but bot chat is already open** — take a snapshot, read the chat header, and test that bot
- **No username, no open chat** — ask the user to open the bot chat manually

**Step-by-step:**

1. **Check the current page** — take a snapshot to see what's on screen. If Telegram Web is visible with a bot chat already open (the chat header shows a bot name — bot names typically end with "bot" or show "bot" in the status line), you can test this bot directly — skip to step 6. This is the primary approach when no bot token or username is available.

2. **Navigate to Telegram Web** (if not already there) — go to `https://web.telegram.org/a/`. The user should already be logged in. If you see a login/QR code screen, stop and tell the user they need to log in manually.

3. **Find the search input** — take a snapshot. Look for:
   - A search field or text input near the top of the chat list (left panel)
   - It's usually labeled "Search" or has placeholder text "Search"
   - In the accessibility tree: a `textbox` or `searchbox` role element

4. **Search for the bot** — type `@<bot_username>` (the username from getMe, e.g., `@MyQuizBot`) into the search field. Wait 2-3 seconds for global search results to load, then take a new snapshot.

5. **Open the bot chat** — in the search results, find the bot entry (it should show the bot's name and username) and click on it. The chat panel should open on the right side. If the bot doesn't appear in results:
   - Try searching without the `@` prefix
   - Try the bot's display name instead of username
   - The bot may be private or not yet started — try navigating directly to `https://t.me/<bot_username>` which may prompt to open in Telegram Web. Caution: t.me links may redirect outside Telegram Web (to app stores or mobile interface). If this happens, navigate back to `web.telegram.org/a/`

6. **Verify you're in the right chat** — take a snapshot and confirm the chat header shows the bot's name/username. You should see the message input at the bottom, meaning the chat is ready for interaction.

---

## 3. Sending Messages and Commands

To send a command like `/start` or `/quiz`:

1. **Find the message input** — take a snapshot. Look for:
   - A textbox at the bottom of the chat area
   - Usually has placeholder text like "Message" or "Write a message..."
   - In the accessibility tree: a textbox or contenteditable element near the bottom

2. **Type the command** — use the browser type tool to enter the text (e.g., `/quiz`) into the message input field found via its ref.

3. **Send the message** — use the `submit: true` option when typing (this presses Enter after typing), OR press the Enter key separately after typing.

4. **Confirm it was sent** — wait 1-2 seconds, take a snapshot, and verify your message appears in the chat as a sent message.

**Tips:**
- Always type the full command including the `/` prefix
- If the message input isn't focused, click on it first before typing
- Telegram Web may show command autocomplete — you can either select from it or just press Enter to send the typed text

---

## 4. Reading Bot Responses

After sending a command, you need to read the bot's response.

1. **Wait for the response** — bot responses via long polling typically arrive within 2-5 seconds. Wait at least 3 seconds after sending.

2. **Take a snapshot** — this gives you the accessibility tree with all visible text.

3. **Find the bot's message** — in the snapshot, look for:
   - Message elements that come after your sent message
   - Text content that matches what you expect from the bot
   - The most recent messages are typically at the bottom of the chat
   - Bot messages often contain structured text with line breaks, emoji, or formatted numbers

4. **Extract the response text** — read the full text of the bot's message. Note:
   - Inline keyboard buttons will appear as separate clickable elements below the message text
   - Multi-line messages may appear as a single text block or split across elements
   - Emoji (like checkmarks or X marks) are part of the text content

5. **If no response appeared** — wait 3 more seconds and snapshot again. If still nothing after 15 seconds total, the bot may have crashed — check its process status using whatever method fits the deployment (docker, pm2, ps, etc.).

---

## 5. Clicking Inline Keyboard Buttons

Telegram bots often use inline keyboards — rows of buttons that appear below a message.

1. **Identify the buttons** — take a snapshot. Inline keyboard buttons appear as:
   - Button-role elements grouped below a message
   - Each button has visible text (the label) and a ref for clicking
   - They're usually arranged in rows

2. **Click the target button** — use the browser click tool with the button's ref from the snapshot.

3. **Wait for the result** — the bot will either:
   - **Edit the original message** (common for quiz answers, confirmations)
   - **Send a new message** (common for next steps, follow-ups)
   - Wait 2-3 seconds after clicking, then take a new snapshot

4. **Read the updated state** — take a snapshot to see:
   - Whether the message was edited (check if the text changed)
   - Whether new messages appeared
   - Whether new inline buttons appeared (next question, etc.)

**Important:**
- Inline keyboard buttons are one-time use in many bots — once clicked, they may disappear or become inactive
- If you see "callback query expired" or similar, the button's callback handler rejected the click (this might be expected behavior for expired flows)
- Some bots show a brief loading indicator on the button before the response appears

---

## 6. Taking Screenshots for Evidence

Screenshots are crucial for the test report. Take them at key moments.

**When to take screenshots:**
- After each bot response (to show what the user would see)
- After clicking inline buttons (to show the result)
- When something unexpected happens (bugs, errors, wrong text)
- Before and after edge case tests
- Final state of each flow

**How to take them:**
- Use the screenshot tool (it saves to a file)
- Name files descriptively: `quiz-q1-response.png`, `score-leaderboard.png`, `bug-expired-callback.png`
- Full page screenshots aren't usually needed — the viewport is enough for Telegram Web

**Screenshot vs Snapshot:**
- **Snapshot** (accessibility tree) = for interaction and reading text (machine-readable)
- **Screenshot** (image) = for visual evidence in the report (human-readable)

---

## 7. Handling Timing and Delays

Telegram Web has inherent latency due to its architecture:

| Action | Expected delay | What to do |
|--------|---------------|------------|
| Message sent → appears in chat | < 1 second | Wait 1s, snapshot |
| Command sent → bot responds | 2-5 seconds | Wait 3s, snapshot. If nothing, wait 3 more |
| Inline button clicked → response | 1-3 seconds | Wait 2s, snapshot |
| Search query → results appear | 1-2 seconds | Wait 1.5s, snapshot |

**General rule**: after any action, wait before snapshotting. If the expected result isn't there, wait once more. Don't rapid-fire snapshots — each one costs context.

**If the bot is consistently slow** (>5 seconds per response), mention it in the report as a performance observation.

---

## 8. Tab Management

The Claude Chrome Extension works with Chrome tabs:

- **New tabs**: Claude may open new tabs for navigation. If needed, use the tabs tool to list, switch between, or close tabs.
- **Right tab**: Before interacting, verify you're on the Telegram Web tab. Take a snapshot — if you see Telegram's interface, you're in the right place.
- **Multiple tabs**: If you need to navigate away (e.g., to check something on another page), open a new tab rather than navigating away from Telegram Web. Then switch back.
- **Don't close the Telegram tab**: The user may need it after testing.

---

## 9. Telegram Web Page Structure

Telegram Web A (`web.telegram.org/a/`) has a consistent layout. Note: Telegram Web updates its frontend over time. If the structure below doesn't match what you see in snapshots, adapt based on the actual accessibility tree. Here's what to expect:

**Left panel (chat list):**
- Search input at the top
- List of chats, each showing: avatar, name, last message preview, timestamp
- Each chat is a clickable element

**Right panel (active chat):**
- Chat header at the top: bot/user name, status (online/last seen/bot)
- Message area in the middle: scrollable list of messages
- Each message has: sender, text content, timestamp
- Inline keyboards appear as button rows below their parent message
- Message input at the bottom: textbox with placeholder text, send button

**Inline keyboard patterns:**
- Buttons are arranged in rows (the bot defines the layout)
- Each button has text label and a click action
- After the bot edits a message (e.g., showing "Correct!" or "Wrong!"), the inline keyboard may disappear from that message

**Key elements to find in snapshots:**
- `textbox` or `[contenteditable]` at bottom → message input
- `button` elements within message area → inline keyboard buttons
- Text content of recent messages → bot responses
- `searchbox` or `textbox` at top of left panel → search field

---

## 10. Troubleshooting

**"Browser extension is not connected"**
→ User should run `/chrome` in Claude Code and reconnect. May need to restart Chrome.

**Snapshot shows unexpected page / not Telegram**
→ You may be on the wrong tab. Use tabs tool to list tabs and switch to the Telegram Web tab.

**Can't find the message input**
→ The chat may not be open. Look for the bot in the chat list and click it first. Or the page may still be loading — wait and retry.

**Bot doesn't respond**
→ Check the bot's process status and logs using whatever method fits the deployment. The bot may have crashed.

**Inline buttons not clickable**
→ The buttons may have expired (bot edited the message and removed them). Send the command again to start a fresh flow.

**Message input already has text**
→ Clear it first by selecting all (Ctrl+A) and deleting, or click the input and type the new command.

**Page asks to log in**
→ The user's Telegram session has expired. They need to log in manually — Claude cannot handle 2FA/QR code auth.

**"Receiving end does not exist" error**
→ Chrome extension service worker went idle. User should run `/chrome` → "Reconnect extension".
