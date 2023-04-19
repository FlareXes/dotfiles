
# ----- User Edits ----- #
export EDITOR="nvim"
export LANG="en_US.UTF-8"
export PATH="/home/radowoo/.local/bin:$PATH"

# ls
alias l='lsd -lh --group-dirs=last'
alias ll='lsd -lah --group-dirs=last'
alias la='lsd -A'
alias lm='lsd -m'
alias lr='lsd -R'
alias lg='lsd -l --group-directories-first'
alias tree='lsd --tree'

# One Char
alias e="exit"
alias c="clear"
alias h="history | cut -c 8- | fzf --tac | xargs -I {} xdotool type --window getactivewindow {}"

# My Alias
alias cat="bat"
alias open='xdg-open'
alias mpv='devour mpv'
alias yt-dlp-audio="yt-dlp -f 'ba' -x --audio-format mp3"
alias myip='curl -4 http://ifconfig.co/ip'
alias joke='curl https://icanhazdadjoke.com'
alias cheat='function _e(){ curl cheat.sh/$1; };_e'
alias speedtest='function _e(){ curl -s https://raw.githubusercontent.com/sivel/speedtest-cli/master/speedtest.py | python3 -; };_e'

