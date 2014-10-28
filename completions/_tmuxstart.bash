# ------------------------------------------------------------------------------
# Description
# -----------
#
#  Completion script for tmuxstart under bash (https://github.com/treyhunner/tmuxstart).
#
# ------------------------------------------------------------------------------
# Authors
# -------
#
#  * Farfanoide (https://github.com/farfanoide)
#
# ------------------------------------------------------------------------------

_tmuxstart()
{
    local cur=${COMP_WORDS[COMP_CWORD]}
    COMPREPLY=( $(compgen -W "$(\ls ${TMUXSTART_DIR:-$HOME/.tmuxstart})" -- $cur) )
}
complete -F _tmuxstart tmuxstart
