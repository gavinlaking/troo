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

  @add
  Scenario: Cannot add a comment as card not found
  Given the Trello API is stubbed with "400_create_comment"
    When I run `troo add comment 400 "My Cucumber Comment"`
    Then the output should contain:
      """
      Comment could not be created.
      """
