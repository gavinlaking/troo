Feature: Refreshing a resource

  @pending
  Scenario: Refresh the board with ID
    Given the Trello API is stubbed with "refresh_board_success"
    And a board exists
    When I run `troo --test refresh board 1`
    Then the output should contain "'My Test Board' refreshed."

  @pending
  Scenario: Cannot refresh; no ID
    When I run `troo --test refresh board`
    Then the output should contain "was called with no arguments"

  @pending
  Scenario: Cannot refresh; board not found
    When I run `troo --test refresh board 69`
    Then the output should contain "Board cannot be found."

  @pending
  Scenario: Refresh the default board
    Given the Trello API is stubbed with "refresh_board_success"
    And a default board exists
    When I run `troo --test refresh board`
    Then the output should contain "'My Default Board' refreshed."

  @pending
  Scenario: Cannot refresh; no default board
    When I run `troo --test refresh board`
    Then the output should contain "Default board cannot be found."

  @pending
  Scenario: Cannot refresh, not authenticated with Trello
    Given the Trello API is stubbed with "unauthenticated"

  @pending
  Scenario: Cannot refresh, Trello not responding
    Given the Trello API is stubbed with "trello_failure"
