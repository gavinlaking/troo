Feature: Adding content to Trello

  @failing @add
  Scenario: Add a board
    Given the Trello API is stubbed with "add_board_success"
    When I run `troo add board "Cuke Add Board"`
    Then the output should contain:
      """
      New board 'Cuke Add Board' created.
      """

  @pending @failing @add
  Scenario: Add a board, name not provided
    Given the Trello API is stubbed with "add_board_interactive_success"
    When I run `troo add board` interactively
    And I type "Cuke Add Board Interactive"
    Then the output should contain:
      """
      New board 'Cuke Add Board Interactive' created.
      """

  @pending @failing @add
  Scenario: Cannot add a board
    Given the Trello API is stubbed with "add_board_failure"
    When I run `troo add board "My New Board"`
    Then the output should contain "Board could not be created."
