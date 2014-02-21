Feature: Adding content to Trello
  Background:
    Given a card exists

  @add
  Scenario: Add a comment
    Given the Trello API is stubbed with "200_create_comment"
    When I run `troo add comment 200 "My Cucumber Comment"`
    Then the output should contain:
      """
      New comment created.
      """

  @pending @failing @add
  Scenario: Add a comment, comment not provided
    Given the Trello API is stubbed with "add_comment_interactive_success"
    When I run `troo add comment` interactively
    And I type "My Cucumber Comment"
    Then the output should contain:
      """
      """

  @add
  Scenario: Cannot add a comment as card not found
  Given the Trello API is stubbed with "400_create_comment"
    When I run `troo add comment 400 "My Cucumber Comment"`
    Then the output should contain:
      """
      Comment could not be created.
      """
