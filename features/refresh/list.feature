Feature: Refreshing a resource

  @pending @refresh
  Scenario: Refresh the list with ID
    Given the Trello API is stubbed with "refresh_list_success"
    And a list exists
    When I run `troo --test refresh list 1`
    Then the output should contain "'My Test List' refreshed."

  @pending @refresh
  Scenario: Cannot refresh; no ID
    When I run `troo --test refresh list`
    Then the output should contain "was called with no arguments"

  @pending @refresh
  Scenario: Cannot refresh; list not found
    When I run `troo --test refresh list 69`
    Then the output should contain "List cannot be found."

  @pending @refresh
  Scenario: Refresh the default list
    Given the Trello API is stubbed with "refresh_list_success"
    And a default list exists
    When I run `troo --test refresh list`
    Then the output should contain "'My Test List' refreshed."

  @pending @refresh
  Scenario: Cannot refresh; no default list
    When I run `troo --test refresh list`
    Then the output should contain "Default list cannot be found."

  @pending @refresh
  Scenario: Cannot refresh, not authenticated with Trello
    Given the Trello API is stubbed with "unauthenticated"

  @pending @refresh
  Scenario: Cannot refresh, Trello not responding
    Given the Trello API is stubbed with "trello_failure"
