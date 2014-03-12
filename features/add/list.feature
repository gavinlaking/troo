Feature: Adding content to Trello
  Background:
    Given a board exists

  @add
  Scenario: Add a list
    Given the Trello API is stubbed with "200_create_list"
    When I run `troo add list 20010 "My Cucumber List"`
    Then the output should contain:
      """
      New list 'My Cucumber List' created.
      """

  @add
  Scenario: Cannot add a list as board not found
    Given the Trello API is stubbed with "400_create_list"
    When I run `troo add list 400 "My Cucumber List"`
    Then the output should contain:
      """
      List could not be created.
      """
