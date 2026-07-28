# Minimal Bash configuration for agent-operated shells.

[[ $- == *i* ]] || return

# Keep interactive sessions predictable: no aliases or prompt framework.
PS1='\u@\h:\w\$ '
