Feature: Removing all local data

  Scenario: User confirms removal should occur
    When I run `troo --test cleanup` interactively
    And I type "yes"
    Then the output should contain "All local data has been removed."

  Scenario: User cancels removal
    When I run `troo --test cleanup` interactively
    And I type "no"
    Then the output should not contain "All local data has been removed."
