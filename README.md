# dotfiles – Bash helper functions

This repo contains handy Bash functions I use regularly, like compressing videos with FFmpeg, cleaning JAR signatures, or extracting data from CSVs.

## 🔧 Setup

To auto-load functions and auto-update the file every 2 weeks, add this to your `~/.bashrc`:

```bash
# Load custom functions
if [ -f ~/dotfiles/.bash_functions ]; then
    . ~/dotfiles/.bash_functions
fi

# Auto pull latest functions every 2 weeks
if find ~/dotfiles/.bash_functions -mtime +14 -print -quit | grep -q .; then
    (cd ~/dotfiles && git pull --quiet)
fi
