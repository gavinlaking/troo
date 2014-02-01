Feature: Refreshing a card

  @refresh
  Scenario: Refresh the card with ID
    Given the Trello API is stubbed with "refresh_card_success"
    And a card exists
    When I run `troo refresh card 1`
    Then the output should contain "refreshed"

  @refresh
  Scenario: Cannot refresh; card not found
    Given the Trello API is stubbed with "refresh_card_not_found"
    When I run `troo refresh card 69`
    Then the output should contain "Card cannot be found"

  @refresh
  Scenario: Refresh the default card
    Given the Trello API is stubbed with "refresh_default_card_success"
    And a default card exists
    When I run `troo refresh card`
    Then the output should contain "refreshed"

  @refresh
  Scenario: Cannot refresh; no default card
    When I run `troo refresh card`
    Then the output should contain "Default card cannot be found"

