Feature: Refreshing a resource

  @refresh
  Scenario: Refresh the board with ID
    Given the Trello API is stubbed with "200_board_by_id"
    And a board exists
    When I run `troo refresh board 200`
    Then the output should contain "refreshed"

  @refresh
  Scenario: Cannot refresh; board not found
    Given the Trello API is stubbed with "400_board_by_id"
    When I run `troo refresh board 400`
    Then the output should contain "Board cannot be found"

  @refresh
  Scenario: Refresh the default board
    Given the Trello API is stubbed with "200_board_by_id"
    And a default board exists
    When I run `troo refresh board`
    Then the output should contain "refreshed"

  @refresh
  Scenario: Cannot refresh; no default board
    When I run `troo refresh board`
    Then the output should contain:
      """
      Board cannot be found. Specify an <id> or use 'troo default board <id>' to set a default board first.
      """
