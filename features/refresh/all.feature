Feature: Refreshing all data

  @refresh
  Scenario: Refreshing the local data
    Given the Trello API is stubbed with "boards_all"
    When I run `troo refresh all`
    Then the output should contain:
      """
      All local data refreshed.
      """

  @failing @refresh
  Scenario: Refreshing the local data fails
    Given the Trello API is stubbed with "400_boards_all"
    When I run `troo refresh all`
    Then the output should contain:
      """
      Cannot refresh all local data.
      """
