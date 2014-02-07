Feature: Adding content to Trello
  Background:
    Given a list exists

  @pending @failing @add
  Scenario: Add a card
    Given the Trello API is stubbed with "add_card_success"
    When I run `troo add card 1 "My Cucumber Card"`
    Then the output should contain:
      """
      New card 'My Cucumber Card' created
      """

  @add
  Scenario: Add a card, name not provided
    Given the Trello API is stubbed with "add_card_failure"
    When I run `troo add card 1 ""`
    Then the output should contain "Card could not be created"

  @pending @failing @add
  Scenario: Add a card, name not provided
    Given the Trello API is stubbed with "add_card_interactive_success"
    When I run `troo --test add card 1`
    And I type "My New Exciting Card"
    Then the output should contain:
      """
      New card 'My New Exciting Card' created
      """

  @pending @failing @add
  Scenario: Add a card to the default list
    Given a default list exists
    Given the Trello API is stubbed with "add_card_success"
    When I run `troo add card "My Cucumber Card"`
    Then the output should contain:
      """
      New card 'My Cucumber Card' created
      """

  @pending @failing @add
  Scenario: Cannot add a card as list not found
    Given the Trello API is stubbed with "add_card_list_not_found"
    When I run `troo add card 69 "My Cucumber Card"`
    Then the output should contain ""

  @pending @failing @add
  Scenario: Cannot add a card as no default list
    When I run `troo add list ""`
    Then the output should contain ""
