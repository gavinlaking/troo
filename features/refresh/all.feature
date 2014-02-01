Feature: Refreshing all data

  @refresh
  Scenario: Refresh the local data
    Given the Trello API is stubbed with "refresh_all_success"
    When I run `troo refresh all`
    Then the output should contain "All local data refreshed."
