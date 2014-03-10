# https://blog.jcoglan.com/2013/02/12/tab-completion-for-your-command-line-apps/

_troo_complete() {
  local word completions
  word="$1"
  completions="$(troo autocomplete "${word}")"
  reply=( "${(ps:\n:)completions}" )
}

compctl -f -K _troo_complete troo
