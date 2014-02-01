Feature: Adding content to Trello
  Background:
    Given a card exists

  @pending @add
  Scenario: Add a comment
    Given the Trello API is stubbed with "add_comment_success"
    When I run `troo add comment 1 ""`
    Then the output should contain ""

  @pending @add
  Scenario: Add a comment, comment not provided
    Given the Trello API is stubbed with "add_comment_success"
    When I run `troo add comment` interactively
    And I type "My New Exciting Comment"
    Then the output should contain ""

  @pending @add
  Scenario: Add comment to the default card
    Given the Trello API is stubbed with "add_comment_success"
    Given a default card exists
    When I run `troo add comment ""`
    Then the output should contain ""

  @pending @add
  Scenario: Cannot add a comment as card not found
    When I run `troo add comment 69 ""`
    Then the output should contain ""

  @pending @add
  Scenario: Cannot add a comment as no default card
    When I run `troo add comment ""`
    Then the output should contain ""

  @pending @add
  Scenario: Cannot add a comment, not authenticated with Trello
    Given the Trello API is stubbed with "unauthenticated"
    Then the output should contain ""

  @pending @add
  Scenario: Cannot add a comment, Trello not responding
    Given the Trello API is stubbed with "trello_failure"
    Then the output should contain ""
