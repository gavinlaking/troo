Feature: Showing a board

  @show
  Scenario: Showing a board with ID
    Given a board exists
    When I run `troo --test show board 1`
    Then the output should contain:
      """
       (1) My Test Board
             No lists were found.
      """

  @show
  Scenario: Cannot show board; not found
    When I run `troo --test show board 69`
    Then the output should contain "Board cannot be found."

  @show
  Scenario: Showing the default board
    Given a default board exists
    When I run `troo --test show board`
    Then the output should contain:
      """
      * (1) My Default Board
             No lists were found.
      """

  @show
  Scenario: Cannot show; no default board
    When I run `troo --test show board`
    Then the output should contain "set a default board first"
