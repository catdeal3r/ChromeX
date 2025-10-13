if status is-interactive
    # Commands to run in interactive sessions can go here
    zoxide init fish --cmd cd | source
    alias c=clear
end

function nd -w "nix develop"
    nix develop .#$argv --command fish
end
