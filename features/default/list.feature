Feature: Setting a default list

  Scenario: Set a list to default
    Given a list exists
    When I run `troo --test default list 1`
    Then the output should contain "'My Test List' set as default list."

  Scenario: Cannot set a default; not found
    When I run `troo --test default list 69`
    Then the output should contain "List cannot be found."

  Scenario: Cannot set a default; no ID
    When I run `troo --test default list`
    Then the output should contain "was called with no arguments"
