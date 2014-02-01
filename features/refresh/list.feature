Feature: Refreshing a resource

  @refresh
  Scenario: Refresh the list with ID
    Given the Trello API is stubbed with "refresh_list_success"
    And a list exists
    When I run `troo refresh list 1`
    Then the output should contain "refreshed"

  @refresh
  Scenario: Cannot refresh; list not found
    Given the Trello API is stubbed with "refresh_list_not_found"
    When I run `troo refresh list 69`
    Then the output should contain "List cannot be found"

  @refresh
  Scenario: Refresh the default list
    Given the Trello API is stubbed with "refresh_default_list_success"
    And a default list exists
    When I run `troo refresh list`
    Then the output should contain "refreshed"

  @refresh
  Scenario: Cannot refresh; no default list
    When I run `troo refresh list`
    Then the output should contain "Default list cannot be found"

