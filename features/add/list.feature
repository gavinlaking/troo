Feature: Adding content to Trello
  Background:
    Given a board exists

  @pending @failing @add
  Scenario: Add a list
    Given the Trello API is stubbed with "add_list_success"
    When I run `troo add list 1 "My Cucumber List"`
    Then the output should contain:
      """
      New list 'My Cucumber Card' created
      """

  @pending @failing @add
  Scenario: Add a list, name not provided
    Given the Trello API is stubbed with "add_list_interactive_success"
    When I run `troo add list` interactively
    And I type "My New Exciting List"
    Then the output should contain ""

  @pending @failing @add
  Scenario: Cannot add a list as board not found
    When I run `troo add list 69 ""`
    Then the output should contain ""
