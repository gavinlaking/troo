Feature: Adding content to Trello
  Background:
    Given a list exists

  @add
  Scenario: Add a card
    Given the Trello API is stubbed with "200_create_card"
    When I run `troo add card 20040 "My Cucumber Card"`
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

  @add
  Scenario: Cannot add a card as list not found
    Given the Trello API is stubbed with "400_create_card"
    When I run `troo add card 400 "My Cucumber Card"`
    Then the output should contain:
    """
    Card could not be created.
    """
