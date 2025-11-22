set -x RIPGREP_CONFIG_PATH $HOME/.config/ripgreprc

if status is-interactive
    # Commands to run in interactive sessions can go here
end

function batman
    man $argv | bat --plain --language man
end
