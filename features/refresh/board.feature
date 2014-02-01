Feature: Refreshing a resource

  @refresh
  Scenario: Refresh the board with ID
    Given the Trello API is stubbed with "refresh_board_success"
    And a board exists
    When I run `troo refresh board 1`
    Then the output should contain "refreshed"

  @refresh
  Scenario: Cannot refresh; board not found
    Given the Trello API is stubbed with "refresh_board_not_found"
    When I run `troo refresh board 69`
    Then the output should contain "Board cannot be found"

  @refresh
  Scenario: Refresh the default board
    Given the Trello API is stubbed with "refresh_default_board_success"
    And a default board exists
    When I run `troo refresh board`
    Then the output should contain "refreshed"

  @refresh
  Scenario: Cannot refresh; no default board
    When I run `troo refresh board`
    Then the output should contain "Default board cannot be found"

  @pending @refresh
  Scenario: Cannot refresh, not authenticated with Trello
    Given the Trello API is stubbed with "unauthenticated"

  @pending @refresh
  Scenario: Cannot refresh, Trello not responding
    Given the Trello API is stubbed with "trello_failure"
