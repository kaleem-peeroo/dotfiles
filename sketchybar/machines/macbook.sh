# -- Right Items (left of notch) --
sketchybar  --add item network e \
            --set   network \
                    icon=􀙇\
                    update_freq=1 \
                    script="$PLUGIN_DIR/network.sh" \

sketchybar  --add item memory e \
            --set   memory \
                    icon=􀫦\
                    update_freq=2 \
                    script="$PLUGIN_DIR/memory.sh" \

sketchybar --add item cpu_temp e \
    --set cpu_temp \
    icon=󰔏\
    update_freq=5 \
    script="$PLUGIN_DIR/cpu_temp.sh" \

sketchybar --add item volume e \
    --set volume \
    icon=􀊠 \
    script="$PLUGIN_DIR/volume.sh" \
    update_freq=1 \
    --subscribe volume volume_change

sketchybar --add item battery e \
           --set battery update_freq=1 \
                         script="$PLUGIN_DIR/battery.sh" \
           --subscribe battery system_woke power_source_change

sketchybar --add item calendar e \
    --set calendar \
    icon=􀉉 \
    label="$(date +'%a %d %b')" \
    update_freq=1 \
    script="$PLUGIN_DIR/calendar.sh"

sketchybar --add item clock e \
    --set clock \
    icon=􀐫 \
    label="$(date +'%H:%M:%S')" \
    update_freq=1 \
    script="$PLUGIN_DIR/clock.sh"

# -- Right Items (right of notch) --
sketchybar  --add item discord q \
            --set   discord \
                    icon=󰙯 \
                    label="0" \
                    update_freq=5 \
                    click_script="open -a Discord" \
                    script="$PLUGIN_DIR/discord.sh"

sketchybar  --add item outlook q \
            --set   outlook \
                    icon=󰴢 \
                    label="0" \
                    update_freq=30 \
                    click_script="open -a 'Microsoft Outlook'" \
                    script="$PLUGIN_DIR/outlook.sh"

sketchybar  --add item teams q \
            --set   teams \
                    icon=":microsoft_teams:" \
                    icon.font="sketchybar-app-font:Regular:16.0" \
                    label="0" \
                    update_freq=5 \
                    click_script="open -a 'Microsoft Teams'" \
                    script="$PLUGIN_DIR/teams.sh"

sketchybar --add item spotify q \
    --set spotify \
    icon.font="sketchybar-app-font:Regular:16.0" \
    icon="" \
    label.drawing=on \
    label.padding_left=2 \
    label.padding_right=5 \
    update_freq=1 \
    click_script="osascript -e 'tell application \"Spotify\" to playpause'" \
    script="$PLUGIN_DIR/spotify.sh" \
    --subscribe spotify front_app_switched

# -- Herdr agents --
sketchybar --add item herdr q \
    --set herdr \
    icon.drawing=off \
    label=" 0 󰂚 0 󰗠 0" \
    label.color=$WHITE \
    update_freq=2 \
    script="$PLUGIN_DIR/herdr_agents.sh"
