eval "$(starship init zsh)"
export PATH="/home/radowoo/.local/bin:$PATH"

# ls
alias l='lsd -lh --group-dirs=last'
alias ll='lsd -lah --group-dirs=last'
alias la='lsd -A'
alias lm='lsd -m'
alias lr='lsd -R'
alias lg='lsd -l --group-directories-first'
alias tree='lsd --tree'

# My Alias
alias mpv='devour mpv'
alias yt-dlp-audio="yt-dlp -f 'ba' -x --audio-format mp3"
alias myip='curl -4 http://ifconfig.co/ip'
alias speedtest='function _e(){ curl -s https://raw.githubusercontent.com/sivel/speedtest-cli/master/speedtest.py | python3 -; };_e'
<<<<<<< HEAD
alias cheat='function _e(){ curl cheat.sh/$1; };_e'
alias joke='curl https://icanhazdadjoke.com'
alias hisfzf="cat .bash_history .zsh_history | cut --complement -f 1 -d ';' | fzf --tac | bash"

