# Load the shared login environment before starting the desktop or a shell.
[[ -r "$HOME/.profile" ]] && source "$HOME/.profile"

# Load the minimal agent shell configuration.
[[ -r "$HOME/.bashrc" ]] && source "$HOME/.bashrc"
