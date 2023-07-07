
## ----- User Edits ----- ##
export EDITOR="nvim"
export LANG="en_US.UTF-8"
export PATH="/home/radowoo/.local/bin:$PATH"

## ls
alias l='lsd -lh --group-dirs=last'
alias ll='lsd -lah --group-dirs=last'
alias la='lsd -A'
alias lr='lsd -R'
alias tree='lsd --tree'

## One Char
alias e="exit"
alias c="clear"
alias h="history | cut -c 8- | fzf --tac | xargs -I {} xdotool type --window getactivewindow {}"

## My Alias
alias cat="bat"
alias open="xdg-open"
alias mpv="devour mpv"
alias shred="shred --verbose --remove --iterations=50"
alias yt-dlp-audio="yt-dlp -f 'ba' -x --audio-format mp3"
alias myip="curl -4 http://ifconfig.co/ip"
alias joke="curl https://icanhazdadjoke.com"

## Function Aliases
alias cheat='function _e(){ curl cheat.sh/$1; };_e'
alias foyay='function _e(){ curl -s https://aur.archlinux.org/cgit/aur.git/plain/PKGBUILD\?h\=$2 | bat --language=PKGBUILD; };_e'

## Long Aliases
alias firewall-up="sudo systemctl enable --now portmaster.service && sudo ufw enable"
alias firewall-down="sudo systemctl disable --now portmaster.service && sudo ufw disable"
alias its-backup-time="time rsync -azh --delete --info=PROGRESS2 --exclude={'.cache','.vscode'} $HOME/ /media/Lifesupport/Lifeshift/$(date +'%F')"

