#compdef tmuxstart
# ------------------------------------------------------------------------------
# Description
# -----------
#
#  Completion script for tmuxstart under zsh (https://github.com/treyhunner/tmuxstart).
#
# ------------------------------------------------------------------------------
# Authors
# -------
#
#  * Farfanoide (https://github.com/farfanoide)
#
# ------------------------------------------------------------------------------
local sessions

sessions=($(\ls ${TMUXSTART_DIR:-$HOME/.tmuxstart}))

_arguments -s \
    '*:Start/Attach session:($sessions)'

