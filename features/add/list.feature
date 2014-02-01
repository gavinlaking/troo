Feature: Adding content to Trello
  Background:
    Given a board exists

  @pending @add
  Scenario: Add a list
    Given the Trello API is stubbed with "add_list_success"
    When I run `troo add list 1 ""`
    Then the output should contain ""

  @pending @add
  Scenario: Add a list, name not provided
    Given the Trello API is stubbed with "add_list_success"
    When I run `troo add list` interactively
    And I type "My New Exciting List"
    Then the output should contain ""

  @pending @add
  Scenario: Add a list to the default board
    Given the Trello API is stubbed with "add_list_success"
    And a default board exists
    When I run `troo add list ""`
    Then the output should contain ""

  @pending @add
  Scenario: Cannot add a list as board not found
    When I run `troo add list 69 ""`
    Then the output should contain ""

  @pending @add
  Scenario: Cannot add a list as no default board
    When I run `troo add list ""`
    Then the output should contain ""

  @pending @add
  Scenario: Cannot add a list, not authenticated with Trello
    Given the Trello API is stubbed with "unauthenticated"
    Then the output should contain ""

  @pending @add
  Scenario: Cannot add a list, Trello not responding
    Given the Trello API is stubbed with "trello_failure"
    Then the output should contain ""
