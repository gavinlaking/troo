Feature: Setting a default list

  @default
  Scenario: Set a list to default
    Given a list exists
    When I run `troo default list 20040`
    Then the output should contain:
      """
      'My Test List' set as default.
      """

  @default
  Scenario: Cannot set a default; not found
    Given the Trello API is stubbed with "400_list_by_id"
    When I run `troo default list 400`
    Then the output should contain "List cannot be found."

  @default
  Scenario: Cannot set a default; no ID
    When I run `troo default list`
    Then the output should contain "was called with no arguments"
