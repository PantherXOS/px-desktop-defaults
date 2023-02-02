#!/usr/bin/env bash

# This script is used to switch btween different window managers for LXQt desktop.

SESSION_CONFIG="$HOME/.config/lxqt/session.conf"
DEFAULE_SESSION_FILE="/run/current-system/profile/etc/xdg/lxqt/session.conf"
LXQT_START_EXECUTABLE="/run/current-system/profile/bin/startlxqt"

usage() {
    echo "Usage: lxqt-switch-desktop.sh [i3|openbox]"
    exit 1
}

log(){
    logger -t lxqt-switch-desktop "$1"
    echo "$1"
}

switch_desktop() {
    log "Switching to $1"
    if [ -f "$SESSION_CONFIG" ]; then
        log "Backing up session.conf to ${SESSION_CONFIG}.bak"
        cp "${SESSION_CONFIG}" "${SESSION_CONFIG}.bak"
    else
        cp "$DEFAULE_SESSION_FILE" "$SESSION_CONFIG"
    fi
    sed -i "s/window_manager=.*/window_manager=$1/" "$SESSION_CONFIG"
}


if [ -z "$1" ]; then
    usage
fi

case "$1" in
    i3|openbox)
        switch_desktop "$1"
        $LXQT_START_EXECUTABLE
        ;;
    *)
        usage
        ;;
esac

