#!/usr/bin/env bash

CURRENT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

get_tmux_option() {
  local option_value
  option_value=$(tmux show-option -gqv "$1")

 if [ -z "$option_value" ]; then
    echo "$2"
  else
    echo "$option_value"
  fi
}

update_status() {
  local status_value
  status_value="$(get_tmux_option "$1")"

  tmux set-option -gq "$1" "${status_value/$k8s_status_placeholder/$k8s_status_draw}"
}

# Commands
k8s_status="#($CURRENT_DIR/scripts/k8s_status.sh)"

# Substitution, change the color of the background here
k8s_status_placeholder="\#{k8s_status}"
k8s_status_draw="#[fg=white,bg=colour27] ${k8s_status} #[fg=default,bg=default]"

# Update left and right
update_status "status-left"
update_status "status-right"