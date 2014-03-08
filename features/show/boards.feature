Feature: Showing all boards

  @show
  Scenario: When boards exist
    Given a board exists
    When I run `troo show boards`
    Then the output should contain:
      """
      (1) My Test Board
          No lists were found.
      """

  @show
  Scenario: When no boards exist
    When I run `troo show boards`
    Then the output should contain:
      """
      Boards cannot be found.
      """
