Feature: Setting a default board

  @default
  Scenario: Set a board to default
    Given a board exists
    When I run `troo default board 1`
    Then the output should contain:
      """
      'My Test Board' set as default board.
      """

  @default
  Scenario: Cannot set a default; not found
    Given the Trello API is stubbed with "fetch_board_by_id"
    When I run `troo default board 69`
    Then the output should contain "Board cannot be found."

  @default
  Scenario: Cannot set a default; no ID
    When I run `troo default board`
    Then the output should contain "was called with no arguments"
