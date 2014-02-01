Feature: Troo Basics

  @basics
  Scenario: Getting the current version
    When I run `troo --test version`
    Then the output should be the version number of troo

  @basics
  Scenario: Running the command with no arguments
    When I run `troo --test`
    Then the output should contain "Commands:"
    And the output should contain "Options:"

  @basics
  Scenario: Running an unknown command
    When I run `troo --test unknown`
    Then the output should contain:
      """
      Could not find command "unknown".
      """
