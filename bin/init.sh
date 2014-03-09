# https://blog.jcoglan.com/2013/02/12/tab-completion-for-your-command-line-apps/

# Add this to your .bash_profile (or .zsh_profile):
#
# Add autocompletion for Troo.
# which troo > /dev/null && . "$(troo path)/init.sh"

if [ -n "$BASH_VERSION" ]; then
  root="$(dirname "${BASH_SOURCE[0]}")"
  source "$root/completion.bash"

elif [ -n "$ZSH_VERSION" ]; then
  root="$(dirname "$0")"
  source "$root/completion.zsh"
fi
