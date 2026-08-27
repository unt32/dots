#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

export EDITOR=vim
export PAGER=less
export LESS=-R

alias ls='ls --color=auto'
alias l='ls --color=auto -lah'
alias grep='grep --color=auto'
alias tree='tree -C'
alias cheat='~/.script/cht.sh'

if [ "$EUID" -eq 0 ]; then
  PS1='\[$(tput setaf 1)\][\u@\h \w]\$\[$(tput sgr0)\] '
else
  PS1='\[$(tput setaf 2)\][\u@\h \w]\$\[$(tput sgr0)\] '
fi

osc7_cwd() {
  local strlen=${#PWD}
  local encoded=""
  local pos c o
  for ((pos = 0; pos < strlen; pos++)); do
    c=${PWD:$pos:1}
    case "$c" in
    [-/:_.!\'\(\)~[:alnum:]]) o="${c}" ;;
    *) printf -v o '%%%02X' "'${c}" ;;
    esac
    encoded+="${o}"
  done
  printf '\e]7;file://%s%s\e\\' "${HOSTNAME}" "${encoded}"
}
PROMPT_COMMAND=${PROMPT_COMMAND:+${PROMPT_COMMAND%;}; }osc7_cwd
