Feature: Adding content to Trello
  Background:
    Given a list exists

  @pending @add
  Scenario: Add a card
    Given the Trello API is stubbed with "add_card_success"
    When I run `troo add card 1 "My Cucumber Card"`
    Then the output should contain:
      """
      New card 'My Cucumber Card' created
      """

  @add_card
  Scenario: Add a card, name not provided
    Given the Trello API is stubbed with "add_card_failure"
    When I run `troo add card 1 ""`
    Then the output should contain "Card could not be created"

  @pending @add
  Scenario: Add a card, name not provided
    Given the Trello API is stubbed with "add_card_success"
    When I run `troo add card 1` interactively
    And I type "My New Exciting Card"
    Then the output should contain:
      """
      New card 'My New Exciting Card' created
      """

  @pending @add
  Scenario: Add a card to the default list
    Given a default list exists
    Given the Trello API is stubbed with "add_card_success"
    When I run `troo add card "My Cucumber Card"`
    Then the output should contain:
      """
      New card 'My Cucumber Card' created
      """

  @pending @add
  Scenario: Cannot add a card as list not found
    When I run `troo add card 69 ""`
    Then the output should contain ""

  @pending @add
  Scenario: Cannot add a card as no default list
    When I run `troo add list ""`
    Then the output should contain ""
