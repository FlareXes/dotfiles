# OH MY ZSH CONFIGURATION
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="archcraft"

## Add wisely, as too many plugins slow down shell startup.
plugins=(git)
source $ZSH/oh-my-zsh.sh


# USER CONFIGURATION
export EDITOR="nvim"
export LANG="en_US.UTF-8"
export MANPAGER="bat -l man -p"
export PATH="/home/$USER/.local/bin:$PATH"

## ls
alias l='lsd -lh --group-dirs=last'
alias ll='lsd -lah --group-dirs=last'
alias la='lsd -A'
alias lr='lsd -R'
alias tree='lsd --tree'

# git
alias gcl='git clone --depth 1'
alias gi='git init'
alias gs='git status'
alias ga='git add'
alias gc='git commit -m'

## One Char
alias e="exit"
alias c="clear"

## My Alias
alias open="xdg-open"
alias cat="bat --theme=Dracula --italic-text=always"
alias shred="shred --verbose --remove --iterations=50"

## Function Aliases
alias cheat='function _e(){ curl cheat.sh/$1; };_e'
