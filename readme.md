# Discord Local AI Bot

This project runs a locally hosted AI-powered Discord bot using [Ollama](https://ollama.com/) and the `llama3` model. It supports both **macOS** (Apple Silicon, Metal acceleration) and **Linux** (via systemd) and remembers each user's prompt history using a local SQLite database.

---

## Features

- Uses locally running LLaMA via Ollama with GPU acceleration
- Discord bot responds to `-ai <your prompt>` with context-aware replies
- Stores prompt/response history per user (SQLite)
- Installable via shell script on Linux or macOS
- No Docker, no cloud API required

---

## Supported Systems

| OS       | Installer Script | Notes                         |
|----------|------------------|-------------------------------|
| macOS    | `install_mac.sh` | Apple Silicon + Metal + Ollama |
| Linux    | `install.sh`     | Debian-based (uses systemd)   |

---

## Requirements

### macOS
- macOS 13+
- Apple Silicon (M1/M2/M3)
- Homebrew
- Ollama installed (`brew install ollama`)
- Python 3 (`brew install python`)
  
### Linux
- Python 3
- Git
- systemd (for auto-start)
- Ollama must be running on the host (use `ollama run llama3`)

---

## 🔧 Installation

### macOS

```bash
git clone https://github.com/yourusername/discord-local-ai.git
cd discord-local-ai
chmod +x install_mac.sh
./install_mac.sh
```

Uninstall with
```bash
chmod +x uninstall_mac.sh
./uninstall_mac.sh
```

### Linux

```
git clone https://github.com/yourusername/discord-local-ai.git
cd discord-local-ai
chmod +x install.sh
./install.sh
```

Uninstall with
```bash
chmod +x uninstall_mac.sh
./uninstall_linux.sh
```

When prompted, paste your Discord bot token.
---

## Usage

Start your Discord bot and then in any channel where it has permissions, type:
```
-ai What is general relativity?
```
It will reply using LLaMA-3 via Ollama and store your interaction in preferences.db.

---

## Running Ollama

Make sure Ollama is running in the background:
```
ollama run llama
```

---

## File Structure

```
discord-local-ai/
├── homie.py               # Main Discord bot file
├── llamaAi.py             # Handles Ollama calls + user preference storage (SQLite)
├── requirements.txt       # Python dependencies
├── .env                   # Environment variables (Discord bot token)
├── install.sh             # Linux setup script with systemd support
├── install_mac.sh         # macOS setup script using virtualenv
├── preferences.db         # SQLite database storing user history
├── homieOfAi.log          # Logs for prompts and responses
└── readme.md              # Project documentation
```

---

## Logs & History
* Logs: homieOfAi.log
* User chat history: preferences.db

---

## License

MIT