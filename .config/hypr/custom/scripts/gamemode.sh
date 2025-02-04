#!/usr/bin/env bash

# Toggle state file
STATE_FILE=~/.config/hypr/gamemode.state

# Check current state
if [ ! -f "$STATE_FILE" ] || [ $(cat "$STATE_FILE") -eq 0 ]; then
    # Enable Game Mode
    echo 1 > "$STATE_FILE"
    
    # Performance optimizations
    hyprctl --batch "
        keyword animations:enabled 0;
        keyword decoration:shadow:enabled 0;
        keyword decoration:blur:enabled 0;
        keyword general:gaps_in 0;
        keyword general:gaps_out 0;
        keyword general:border_size 1;
        keyword decoration:rounding 0;
        keyword misc:no_vfr 1;
        keyword misc:vrr 1;
        keyword layerrule noanim, waybar;
        keyword layerrule noanim, notifications;
        keyword layerrule noanim, swww;
        keyword layerrule noanim, launcher"
    
    # Set all windows to opaque
    hyprctl keyword windowrulev2 opaque,class:.*
    
    # Optional: Notify user
    notify-send "Game Mode" "Enabled" -i applications-games
    
else
    # Disable Game Mode
    echo 0 > "$STATE_FILE"
    
    # Reload config to restore settings
    hyprctl reload
    
    # Optional: Notify user
    notify-send "Game Mode" "Disabled" -i applications-games
fi
