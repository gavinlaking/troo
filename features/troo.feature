Feature: Troo Basics

  @basics
  Scenario: Getting the current version
    When I run `troo version`
    Then the output should be the version number of troo

  @basics
  Scenario: Running the command with no arguments
    When I run `troo`
    Then the output should contain "Commands:"

  @basics
  Scenario: Running an unknown command
    When I run `troo unknown`
    Then the output should contain:
      """
      Could not find command "unknown".
      """

  @pending @authentication
  Scenario: Not authenticated with Trello
    When I run `troo default board 401`
    Then the output should contain ""

  @pending @connectivity
  Scenario: Trello not responding
    When I run `troo default board 401`
    Then the output should contain ""

  @pending @connectivity
  Scenario: No network connection
    When I run `troo default board 401`
    Then the output should contain ""

