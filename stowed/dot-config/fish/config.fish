set -x RIPGREP_CONFIG_PATH $HOME/.config/ripgreprc

if status is-interactive
    # Commands to run in interactive sessions can go here
end

function batman
    man $argv | bat --plain --language man
end

set -gx PATH $PATH /opt/homebrew/opt/llvm/bin

set -gx RBENV_ROOT $HOME/.rbenv
set -gx PATH $RBENV_ROOT/shims $PATH
status --is-interactive; and source (rbenv init - | psub)

