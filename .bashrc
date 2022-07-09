#!/usr/bin/bash
#
# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# 自己添加
# PS1="\u@\h: \w [\A \d]\n(\$?) \\$ \[$(tput sgr0)\]"
PS1="\[\033[01;33m\]\u@\H: \w [\D{%R %A,%e %B %Y (%Z)}]\n(\$?) \\$\[\033[0m\] \[$(tput sgr0)\]"
export PS1

if [[ $UID -ge 1000 && -d $HOME/bin && -z $(echo "$PATH" | grep -o "$HOME/bin") ]]; then
    export PATH=$HOME/bin:${PATH}
fi
if [[ $UID -ge 1000 && -d $HOME/.local/bin && -z $(echo "$PATH" | grep -o "$HOME/.local/bin") ]]; then
    export PATH=$HOME/.local/bin:${PATH}
fi
export PATH=$PATH:/usr/local/lib
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/lib

# tab自动完成文件名和命令
complete -cf sudo

# 用上下键历史记录自动完成
bind '"\e[A": history-search-backward'
bind '"\e[B": history-search-forward'

export HISTCONTROL=erasedups
export HISTSIZE=10000
export HISTFILESIZE=20000

# Mimic Zsh run-help ability
run-help() { help "$READLINE_LINE" 2>/dev/null || man "$READLINE_LINE"; }
bind -m vi-insert -x '"\eh": run-help'
bind -m emacs -x     '"\eh": run-help'

# Disable Ctrl+z in terminal
trap "" SIGTSTP

# Auto "cd" when entering just a path
shopt -s autocd

# Prevent overwrite of files
set -o noclobber

# Line wrap on window resize
shopt -s checkwinsize

# Shell exits even if ignoreeof set
export IGNOREEOF=100

#「Ctrl+S」を無効化する
if [[ -t 0 ]]; then
  stty stop undef
  stty start undef
fi

# 自用命令别名
alias c='clear'
alias s='sync'
alias e='exit'
alias a='awk'
alias g='grep'
alias rm='rm -f'
alias bc='bc -iq'
#alias mirror='rsync --archive --delete --compress -hh --info=stats1,progress2 --modify-window=1'
alias cp='rsync --archive --compress -hh --info=stats1,progress2 --modify-window=1'
#alias mv='rsync --archive --compress -hh --info=stats1,progress2 --modify-window=1 --remove-source-files'
alias wipe='shred -uvz'
alias date='TZ="Asia/Shanghai" date +"%Z: %Y年%-m月%-d日 %A %-H:%M:%S"; TZ="Asia/Tokyo" date +"%Z: %Y年%-m月%-d日 %A %-H:%M:%S";TZ="America/New_York" date +"%Z: %Y年%-m月%-d日 %A %-H:%M:%S";  TZ="Europe/London" date +"%Z: %Y年%-m月%-d日 %A %-H:%M:%S"; TZ="UTC" date +"%Z: %Y年%-m月%-d日 %A %-H:%M:%S"'
alias lsblk='lsblk -o NAME,FSTYPE,SIZE,MOUNTPOINT,LABEL'
alias astyle='astyle -A1 -p -s4 -xC80 -c'
alias pcc='pcc -Wall -Wpedantic -Wextra -std=c99'
alias gcc='gcc -Wall -Wpedantic -Wextra -std=c99'
alias clang='clang -Wall -Wpedantic -Wextra -std=c99'
alias 7zip='7za a -t7z -m0=lzma -mx=9 -mfb=64 -md=32m -ms=on'
#alias dd='dd conv=fsync oflag=direct status=progress'
alias poweroff='sudo shutdown -P now'
alias reboot='sudo shutdown -r now'
alias hwinfo='hwinfo --short --cpu --disk --listmd --gfxcard --wlan --printer'
alias L='|$PAGER'
alias N='>/dev/null 2>&1'
alias N1='>/dev/null'
alias N2='2>/dev/null'

cpr() {
  rsync --archive -hh --partial --info=stats1,progress2 --modify-window=1 "$@"
} 
mvr() {
  rsync --archive -hh --partial --info=stats1,progress2 --modify-window=1 --remove-source-files "$@"
}

# git快捷命令
alias gitsocks='git -c http.proxy=socks5://127.0.0.1:7890'
alias g='git'
alias gs='git status'
alias gb='git branch'
alias gc='git checkout'
alias gct='git commit --gpg-sign=17C22010D29A50BC'
alias gg='git grep'
alias ga='git add'
alias gd='git diff'
alias gl='git log'
alias gcma='git checkout master'
alias gfu='git fetch upstream'
alias gfo='git fetch origin'
alias gmod='git merge origin/develop'
alias gmud='git merge upstream/develop'
alias gmom='git merge origin/master'
alias gcm='git commit -m'
alias gp='git push'
alias gpo='git push origin'
alias gpom='git push origin master'
alias gs='git status'
alias gst='git stash'
alias gsl='git stash list'
alias gsu='git stash -u'
alias gsp='git stash pop'

alias lftp='lftp -u mike,123456 192.168.50.9'
alias tlmgr='/usr/share/texmf-dist/scripts/texlive/tlmgr.pl --usermode'
alias ping4='ping -4'
alias ping6='ping -6'
alias vi='nvi'
alias vim='nvim'

# gpg
alias gpglk='gpg --list-keys --keyid-format=long'
alias gpglsk='gpg --list-secret-keys --keyid-format=long'
alias gpge='gpg --encrypt --recipient 14F27367B1323515B1F61A815BDC731777049B5F'
alias gpgd='gpg --decrypt'

# 默认编辑器
export VISUAL="/usr/bin/nvim"
export EDITOR="/usr/bin/nvim"
export SUDO_EDITOR="/usr/bin/nvim"
export PAGER="/usr/bin/less"

# curl的代理只用这些环境变量
#export http_proxy="http://127.0.0.1:7890"
#export HTTPS_PROXY="http://127.0.0.1:7890"
# 其他代理
#export https_proxy="http://127.0.0.1:7890"
#export HTTP_PROXY="${http_proxy}"
# go语言用代理？
export GOPROXY="https://goproxy.io,direct"

# rar默认压缩参数
#export RAR='-m5 -rr5 -s -md128 -ol'

# 刻录用
export MKISOFS="xorrisofs"
# 强制cdrecord使用最低写入速度写入cd
export CDR_SPEED=1

# zip默认压缩参数
export ZIPOPT='-9'

# 自用
alias ls='ls -h -l --color=auto --time-style=+"%Y-%m-%d %H:%M"'
alias l='ls -CF --color=auto'
alias lh='ls -lh --color=auto'
alias ll='ls -l --color=auto'
alias la='ls -A --color=auto'
alias l.='ls -d .* --color=auto'
alias dir='ls -ba'
alias cal='cal -S -m --color=auto'
alias grep='grep --color=auto -i'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias diff='diff -rauN --color=auto'
# 使用单词级别比较的diff
#alias diff='git diff --no-index --color-words'
alias ip='ip --color=auto'
alias fdisk='fdisk --color'
alias curl='curl --remove-on-error'

# gnupg tty
GPG_TTY=$(tty)
export GPG_TTY

umask 002

# direnv钩子
eval "$(direnv hook bash)"


# vim: set et sw=4 sts=4 tw=80 ft=sh:

