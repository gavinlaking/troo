Feature: Adding content to Trello
  Background:
    Given a list exists

  @pending
  Scenario: Add a card
    Given the Trello API is stubbed with "add_card_success"
    When I run `troo --test add card id ""`
    Then the output should contain ""

  @pending
  Scenario: Add a card, name not provided
    Given the Trello API is stubbed with "add_card_success"
    When I run `troo --test add card` interactively
    And I type "My New Exciting Card"
    Then the output should contain ""

  @pending
  Scenario: Add a card to the default list
    Given the Trello API is stubbed with "add_card_success"
    And a default list exists
    When I run `troo --test add card ""`
    Then the output should contain ""

  @pending
  Scenario: Cannot add a card as list not found
    When I run `troo --test add card 69 ""`
    Then the output should contain ""

  @pending
  Scenario: Cannot add a card as no default list
    When I run `troo --test add list ""`
    Then the output should contain ""

  @pending
  Scenario: Cannot add a card, not authenticated with Trello
    Given the Trello API is stubbed with "unauthenticated"
    Then the output should contain ""

  @pending
  Scenario: Cannot add a card, Trello not responding
    Given the Trello API is stubbed with "trello_failure"
    Then the output should contain ""
