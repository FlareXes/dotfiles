# OH MY ZSH CONFIGURATION
#########################
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="archcraft"

## Add wisely, as too many plugins slow down shell startup.
plugins=(zsh-syntax-highlighting git)
source $ZSH/oh-my-zsh.sh

## execute
eval "$(zoxide init --cmd cd zsh)"

# USER CONFIGURATION
####################
export EDITOR="nvim"
export LANG="en_US.UTF-8"
export PATH="$PATH:$HOME/.scripts:$HOME/.local/bin"

## Source private config if exists
if [ -f "$HOME/.zshrc.local" ]; then
  source "$HOME/.zshrc.local"
fi

## ls
alias ls='eza --group-directories-first'
alias l='eza -l --group-directories-last'
alias ll='eza -la --group-directories-last'
alias la='eza -a --group-directories-last'
alias lr='eza -R'
alias tree='eza --tree'

## git
alias gcl='git clone --depth 1'
alias gi='git init'
alias gs='git status'
alias ga='git add'
alias gc='git commit -m'

## One Char
alias v="nvim"
alias e="exit"
alias c="clear"
alias h="history"

## My Alias
alias imv="imv-dir"
alias open="xdg-open"
alias copy="wl-copy"
alias paste="wl-paste"
alias cat="bat --theme=Dracula --italic-text=always"
alias shred55="shred --verbose --remove --iterations=55"
alias mktest="mkdir /tmp/test/; cd /tmp/test/; pwd"

## Online Alias
alias yt-dlp-audio="yt-dlp -f 'ba' -x --audio-format mp3"
alias myip="curl -4 http://ifconfig.co/ip"

## Functions
yaycat() { yay -Gp "$1" | bat --theme=Dracula -l PKGBUILD }
cheat() { curl -s "https://cheat.sh/$1" }

