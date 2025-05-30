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

Install
```bash
git clone https://github.com/yourusername/discord-local-ai.git
cd discord-local-ai
chmod +x ./install.sh
./install.sh
```

Uninstall
```bash
chmod +x ./uninstall.sh
./uninstall.sh
```

When prompted, paste your Discord bot token.
If using github secrets uncomment lines 20, 21, 22, and 23 in lib/macos/scripts/install_mac.sh AND comment out line 19
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
└── discord-local-ai                            # Root
    ├── db
    │   └── preferences.db                      # SQLite database storing user history
    ├── install.sh                              # Runs instal script based on system OS  
    ├── lib
    │   ├── ansible
    │   │   └── discord_bot.yml                 # Ansible yml file (NEEDS UPDATE)
    │   ├── homie
    │   │   ├── __pycache__                     
    │   │   │   └── llamaAi.cpython-313.pyc     # Python auto generated file for bytecode
    │   │   ├── .env                            # Environment variables (Discord bot token)
    │   │   ├── homie.py                        # Main Discord bot file
    │   │   ├── llamaAi.py                      # Handles Ollama calls + user preference storage (SQLite)
    │   │   └── requirements.txt                # Python dependencies
    │   ├── linux
    │   │   └── scripts
    │   │       ├── install_linux.sh            # Linux setup script with systemd support
    │   │       └── uninstall_linux.sh          # Linux uninstall script
    │   └── macos
    │       └── scripts
    │           ├── install_mac.sh              # macOS setup script using virtualenv
    │           └── uninstall_mac.sh            # macOS uninstall script
    ├── LICENSE                                 # MIT LICENSE
    ├── logs
    │   └── homieOfAi.log                       # Logs for prompts and responses
    └── readme.md                               # Project documentation
```

---

## Logs & History
* Logs: homieOfAi.log
* User chat history: preferences.db

---

## License

MIT