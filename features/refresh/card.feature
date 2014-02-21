Feature: Refreshing a card

  @failing @refresh
  Scenario: Refresh the card with ID
    Given the Trello API is stubbed with "200_card_by_id"
    And a card exists
    When I run `troo refresh card 200`
    Then the output should contain "refreshed"

  @refresh
  Scenario: Cannot refresh; card not found
    Given the Trello API is stubbed with "400_card_by_id"
    When I run `troo refresh card 400`
    Then the output should contain "Card cannot be found"

  @failing @refresh
  Scenario: Refresh the default card
    Given the Trello API is stubbed with "200_card_by_id"
    And a default card exists
    When I run `troo refresh card`
    Then the output should contain "refreshed"

  @refresh
  Scenario: Cannot refresh; no default card
    When I run `troo refresh card`
    Then the output should contain:
      """
      Card cannot be found. Specify an <id> or use 'troo default card <id>' to set a default card first.
      """

