# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

alias quit='exit'
alias q='exit'

alias gitk='(gitk --argscmd="git rev-list --no-walk --branches" --since="2 weeks ago" &> /dev/null &)'
alias g='git'

alias dev-up='pkill -9 spring; dev up'
alias dev-down='dev down; pkill -9 spring'
alias dev-reup='dev down; pkill -9 spring; dev up'
alias dev-api-client-recreate='bundle exec rake dev:api_client:create TYPE=private BETA=draft_orders_api'

alias subl='/Applications/Sublime\ Text.app/Contents/SharedSupport/bin/subl'
