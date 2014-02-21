Feature: Adding content to Trello

  @add
  Scenario: Add a board
    Given the Trello API is stubbed with "200_create_board"
    When I run `troo add board "My Cucumber Board"`
    Then the output should contain:
      """
      New board 'My Cucumber Board' created.
      """

  # undefined method `stdin' for #<Aruba::InProcess
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
    Given the Trello API is stubbed with "400_create_board"
    When I run `troo add board "My Cucumber Board"`
    Then the output should contain:
      """
      Board could not be created.
      """
