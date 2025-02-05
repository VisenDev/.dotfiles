if status is-interactive
    # Commands to run in interactive sessions can go here
end

setfont /usr/share/kbd/consolefonts/ter-928b.psf.gz

set i2p_browser "chromium --proxy-server=\"http://127.0.0.1:4444\""
#set GHOSTTY_RESOURCES_DIR ~/zig/ghostty/zig-out/share/ghostty/
set XDG_CURRENT_DESKTOP Hyprland

function add_cwd_to_path --on-variable PWD
    set -g fish_user_paths $PWD $fish_user_paths
end
