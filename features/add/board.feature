Feature: Adding content to Trello

  Scenario: Add a board
    Given the Trello API is stubbed with "add_board_success"
    When I run `troo --test add board "Cuke Add Board"`
    Then the output should contain "New board 'Cuke Add Board' created."

  @pending
  Scenario: Add a board, name not provided
    Given the Trello API is stubbed with "add_board_interactive_success"
    When I run `troo --test add board` interactively
    And I type "My New Exciting Board"
    Then the output should contain ""

  @pending
  Scenario: Cannot add a board
    Given the Trello API is stubbed with "add_board_failure"
    When I run `troo --test add board "My New Board"`
    Then the output should contain ""

  @pending
  Scenario: Cannot add a board, not authenticated with Trello
    Given the Trello API is stubbed with "unauthenticated"
    Then the output should contain ""

  @pending
  Scenario: Cannot add a board, Trello not responding
    Given the Trello API is stubbed with "trello_failure"
    Then the output should contain ""
