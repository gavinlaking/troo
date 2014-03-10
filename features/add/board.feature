Feature: Adding content to Trello

  @add
  Scenario: Add a board
    Given the Trello API is stubbed with "200_create_board"
    When I run `troo add board "My Cucumber Board"`
    Then the output should contain:
      """
      New board 'My Cucumber Board' created.
      """
