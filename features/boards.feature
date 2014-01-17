Feature: Managing boards

# Scenario: Adding a new board
#   When I run `troo add board`

Scenario: Setting a default board
  When I run `troo default board`

# Scenario: Show all the boards with lists
#   When I run `troo show boards`

Scenario: Show lists and cards for a board
  When I run `troo show board`
