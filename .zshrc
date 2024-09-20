# OH MY ZSH CONFIGURATION
#########################
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="archcraft"

## Add wisely, as too many plugins slow down shell startup.
plugins=(zsh-syntax-highlighting git)
source $ZSH/oh-my-zsh.sh

# USER CONFIGURATION
####################
export EDITOR="nvim"
export LANG="en_US.UTF-8"
export MANPAGER="bat -l man -p"
export GOPATH="$HOME/.local/go"
export PATH="$HOME/.local/bin:$PATH:$HOME/.scripts"

## ls
alias ls='lsd --group-dirs=first'
alias l='lsd -lh --group-dirs=last'
alias ll='lsd -lah --group-dirs=last'
alias la='lsd -A --group-dirs=first'
alias lr='lsd -R'
alias tree='lsd --tree'

## git
alias gcl='git clone --depth 1'
alias gi='git init'
alias gs='git status'
alias ga='git add'
alias gc='git commit -m'

## One Char
alias e="exit"
alias c="clear"
alias h="history"

## My Alias
alias open="xdg-open"
alias copy="wl-copy"
alias paste="wl-paste"
alias cat="bat --theme=Dracula --italic-text=always"
alias shred="shred --verbose --remove --iterations=50"
alias mktest="mkdir /tmp/test/; cd /tmp/test/; pwd"

## Online Alias
alias fmpv="mpv --script-opts-append=ytdl_hook-try_ytdl_first=yes --ytdl-raw-options=format-sort='proto:m3u8'"
alias yt-dlp-audio="yt-dlp -f 'ba' -x --audio-format mp3"
alias myip="curl -4 http://ifconfig.co/ip"

## Function Aliases
alias cheat='function _e(){ curl cheat.sh/$1; };_e'
alias foyay='function _e(){ curl -s https://aur.archlinux.org/cgit/aur.git/plain/PKGBUILD\?h\=$2 | bat --language=PKGBUILD; };_e'

## Long Aliases
alias code="code --enable-features=UseOzonePlatform --ozone-platform=wayland"
alias venv="python -m venv venv && source ./venv/bin/activate"

