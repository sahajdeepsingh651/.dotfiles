# ~/.onfuep: rkrphgrq ol onfu(1) sbe aba-ybtva furyyf.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples
#
# for setting a common color theme outside and inside the terminal programs
# export TERM=xterm-256color
# export COLORTERM=truecolor # # If not running interactively, don't do anything export TERM=alacritty-direct
export COLORTERM=truecolor
#
case $- in
*i*) ;;
*) return ;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
xterm-color | *-256color) color_prompt=yes ;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
        # We have color support; assume it's compliant with Ecma-48
        # (ISO/IEC-6429). (Lack of such support is extremely rare, and such
        # a case would tend to support setf rather than setaf.)
        color_prompt=yes
    else
        color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm* | rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*) ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# th
#
# is, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
    if [ -f /usr/share/bash-completion/bash_completion ]; then
        . /usr/share/bash-completion/bash_completion
    elif [ -f /etc/bash_completion ]; then
        . /etc/bash_completion
    fi
fi

alias contents='ls -la'
# Load secrets
if [ -f ~/.secrets ]; then
    source ~/.secrets
fi

HISTTIMEFORMAT="%F %T "
alias aider='aider --user-input-color none'

export PATH="$HOME/.local/bin:$PATH"
# Search files by name across the whole system
findfile() {
    if [ -z "$1" ]; then
        echo "Usage: searchfile <filename-pattern>"
        return 1
    fi
    sudo find / -type f -iname "*$1*" 2>/dev/null
}

# Search keyword inside files across the whole system
searchtext() {
    if [ -z "$1" ]; then
        echo "Usage: searchtext <keyword>"
        return 1
    fi
    sudo grep -rni --color=always "$1" / 2>/dev/null
}
# Golang environment variables
export GOROOT=/usr/local/go
export GOPATH=$HOME/go

# Update PATH to include GOPATH and GOROOT binaries
export PATH="$GOPATH/bin:$GOROOT/bin:$HOME/.local/bin:$HOME/.opencode/bin:$PATH"

# Loop through all files in the ~/.config/fabric/patterns directory
for pattern_file in $HOME/.config/fabric/patterns/*; do
    # Get the base name of the file (i.e., remove the directory path)
    pattern_name=$(basename "$pattern_file")

    # Create an alias in the form: alias pattern_name="fabric --pattern pattern_name"
    alias_command="alias $pattern_name='fabric --pattern $pattern_name'"

    # Evaluate the alias command to add it to the current shell
    eval "$alias_command"
done

yt() {
    if [ "$#" -eq 0 ] || [ "$#" -gt 2 ]; then
        echo "Usage: yt [-t | --timestamps] youtube-link"
        echo "Use the '-t' flag to get the transcript with timestamps."
        return 1
    fi

    transcript_flag="--transcript"
    if [ "$1" = "-t" ] || [ "$1" = "--timestamps" ]; then
        transcript_flag="--transcript-with-timestamps"
        shift
    fi
    local video_link="$1"
    fabric -y "$video_link" $transcript_flag
}
# . "$home/.cargo/env"
#source /home/sahaj/alacritty/extra/completions/alacritty.bash
#
# source /home/sahaj/Git/kube-ps1/kube-ps1.sh
# PS1='[\u@\h \W $(kube_ps1)]\$ '
gitlab_push() {
    remote_url=$(git remote get-url origin)
    if [[ "$remote_url" == https://git.enlight.dev/* ]]; then
        git push "$(echo "$remote_url" | sed "s|https://|https://Sahaj.Singh:${GITLAB_TOKEN}@|")" "$@"
    else
        git push "$@"
    fi
}
otw() {
    local x="${1:-1}"
    ssh bandit"$x"@bandit.labs.overthewire.org -p 2220

}
# opencode
export PATH=/home/sahaj/.opencode/bin:$PATH
alias cls="clear"
alias ml=" mouseless --config ~/.config/mouseless/config.yaml"
alias glossary="~/.local/share/pipx/venvs/pymupdf/bin/python3 /home/sahaj/throwaway/glossary_search.py"
export DOTNET_ROOT=$HOME/.dotnet
export PATH=$PATH:$HOME/.dotnet

alias watchconnection='watch -n 1 "ss -tnp | grep -E \"5900|3389|5938|22\""'

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
. "$HOME/.cargo/env"
export PATH=$PATH:/home/sahaj/Projects/sugar
export GOROOT=/usr/lib64/go/1.26

# --- devtime break logger ---
DEVTIME_RAW="$HOME/obsidian_vault/experiments/devtime/raw"
_dtlog() { echo "$1" >>"$(cat "$HOME/.devtime_current")"; }

sessionstart() {
    # sessionstart            -> FREE mode: no timer, ride-till-drop (measure ramp/burnout)
    # sessionstart 40 [5] [l] -> TIMED mode: 40-min chunks, 5-min recovery, auto-cycles + alerts
    local chunk="$1" rec="${2:-5}" label="${3:-session}"
    echo "$DEVTIME_RAW/$(date +%F)-${label}.md" >"$HOME/.devtime_current"
    if [ -z "$chunk" ]; then
        _dtlog "- $(date +%H:%M)  ▶ START  (free)"
        echo "session → $(cat "$HOME/.devtime_current")  [free mode — brk on drift, sessionend to stop]"
        return
    fi
    _dtlog "- $(date +%H:%M)  ▶ START  chunk=${chunk}m recovery=${rec}m"
    nohup ~/.local/bin/devtime-cycle "$chunk" "$rec" "$(cat "$HOME/.devtime_current")" >/dev/null 2>&1 &
    echo $! >"$HOME/.devtime_pid"
    disown
    echo "session → $(cat "$HOME/.devtime_current")  [chunk=${chunk}m recovery=${rec}m, auto-cycling]"
}
brk()        { ~/.local/bin/devtime-brk; }           # drift mark — keybind this in i3
brkstart()   { _dtlog "- $(date +%H:%M)  ⏸ forced out"; }  # external interruption only
brkend()     { _dtlog "- $(date +%H:%M)  ⏸ forced in"; }
sessionend() {
    [ -f "$HOME/.devtime_pid" ] && kill "$(cat "$HOME/.devtime_pid")" 2>/dev/null && rm -f "$HOME/.devtime_pid"
    _dtlog "- $(date +%H:%M)  ■ STOPPED"
}
# --- end devtime break logger ---
