#!/bin/bash
set -e

function partition() {
  echo $1
  echo -e "--------------------------------------------------------"
}

if [ -e ./bin/troo ]
then
  partition "init"
  ./bin/troo init

  partition "version"
  ./bin/troo version

  partition "status"
  ./bin/troo status

  partition "refresh all"
  ./bin/troo refresh all

  partition "refresh board 1"
  ./bin/troo refresh board 1

  partition "refresh list 1"
  ./bin/troo refresh list 1

  partition "refresh card 1"
  ./bin/troo refresh card 1

  partition "show board 1"
  ./bin/troo show board 1

  partition "show list 1"
  ./bin/troo show list 1

  partition "show card 1"
  ./bin/troo show card 1

  partition "show comments 1"
  ./bin/troo show comments 1

  partition "default board 1"
  ./bin/troo default board 1

  partition "default list 1"
  ./bin/troo default list 1

  partition "default card 1"
  ./bin/troo default card 1

  partition "cleanup"
  ./bin/troo cleanup

  partition "All done!"
else
  echo -e "\nExecute this from the root of the project, i.e: ./test/system_test.sh\n"
fi

# troo  add [board|list|card|comment] <id>   # Add board, list, card or comment.
# troo  move <card_id> <list_id> # Move card to list.
