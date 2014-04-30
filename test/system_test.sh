#!/bin/bash
set -e

function partition() {
  echo -e "--------------------------------------------------------"
  echo $1
  echo -e "--------------------------------------------------------"
}

if [ -e ./bin/troo ]
then
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

  partition "add board 'Test Board'"
  ./bin/troo add board 'Test Board'

  partition "add list 1 'Test List'"
  ./bin/troo add list 1 'Test List'

  partition "add card 1 'Test Card'"
  ./bin/troo add card 1 'Test Card'

  partition "add comment 1 'Test Comment'"
  ./bin/troo add comment 1 'Test Comment'

  partition "cleanup"
  ./bin/troo cleanup

  partition "All done!"
  echo -e ""
else
  echo -e "\nExecute this from the root of the project, i.e: ./test/system_test.sh\n"
fi

# troo  move <card_id> <list_id> # Move card to list.
