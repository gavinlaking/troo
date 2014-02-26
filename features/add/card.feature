Feature: Adding content to Trello
  Background:
    Given a list exists

  @add
  Scenario: Add a card
    Given the Trello API is stubbed with "200_create_card"
    When I run `troo add card 200 "My Cucumber Card"`
    Then the output should contain:
      """
      New card 'My Cucumber Card' created.
      """

  @add
  Scenario: Add a card, name not provided
    Given the Trello API is stubbed with "400_create_card"
    When I run `troo add card 400 ""`
    Then the output should contain:
      """
      Card could not be created.
      """

  @pending @failing @add
  Scenario: Add a card, name not provided
    Given the Trello API is stubbed with "add_card_interactive_success"
    When I run `troo --test add card 200`
    And I type "My Cucumber Card"
    Then the output should contain:
      """
      New card 'My Cucumber Card' created.
      """

  @add
  Scenario: Cannot add a card as list not found
    Given the Trello API is stubbed with "400_create_card"
    When I run `troo add card 400 "My Cucumber Card"`
    Then the output should contain:
    """
    Card could not be created.
    """
