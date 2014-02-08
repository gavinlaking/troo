Feature: Adding content to Trello
  Background:
    Given a card exists

  @pending @failing @add
  Scenario: Add a comment
    Given the Trello API is stubbed with "add_comment_success"
    When I run `troo add comment 69 ""`
    Then the output should contain ""

  @pending @failing @add
  Scenario: Add a comment, comment not provided
    Given the Trello API is stubbed with "add_comment_interactive_success"
    When I run `troo add comment` interactively
    And I type "My New Exciting Comment"
    Then the output should contain ""

  @pending @failing @add
  Scenario: Cannot add a comment as card not found
    When I run `troo add comment 69 ""`
    Then the output should contain ""
