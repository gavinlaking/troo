Feature: Refreshing a resource

  @refresh
  Scenario: Refresh the list with ID
    Given the Trello API is stubbed with "200_list_by_id"
    And a list exists
    When I run `troo refresh list 20040`
    Then the output should contain "refreshed"

  @refresh
  Scenario: Cannot refresh; list not found
    Given the Trello API is stubbed with "400_list_by_id"
    When I run `troo refresh list 400`
    Then the output should contain "List cannot be found"

  @refresh
  Scenario: Refresh the default list
    Given the Trello API is stubbed with "200_list_by_id"
    And a default list exists
    When I run `troo refresh list`
    Then the output should contain "refreshed"

  @refresh
  Scenario: Cannot refresh; no default list
    When I run `troo refresh list`
    Then the output should contain:
      """
      List cannot be found. Specify an <id> or use 'troo default list <id>' to set a default list first.
      """

