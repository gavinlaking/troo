# https://blog.jcoglan.com/2013/02/12/tab-completion-for-your-command-line-apps/

_troo_complete() {
  COMPREPLY=()
  local word="${COMP_WORDS[COMP_CWORD]}"
  local completions="$(troo autocomplete "$word")"
  COMPREPLY=( $(compgen -W "$completions" -- "$word") )
}

complete -f -F _troo_complete troo
