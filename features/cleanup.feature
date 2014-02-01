Feature: Removing all local data

  @cleanup
  Scenario: User confirms removal should occur
    When I run `troo cleanup` interactively
    And I type "yes"
    Then the output should contain "All local data has been removed."

  @cleanup
  Scenario: User cancels removal
    When I run `troo cleanup` interactively
    And I type "no"
    Then the output should not contain "All local data has been removed."
