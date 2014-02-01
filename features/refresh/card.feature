Feature: Refreshing a card

  @pending @refresh
  Scenario: Refresh the card with ID
    Given the Trello API is stubbed with "refresh_card_success"
    And a card exists
    When I run `troo refresh card 1`
    Then the output should contain "'My New Card' refreshed."

  @pending @refresh
  Scenario: Cannot refresh; no ID
    When I run `troo refresh card`
    Then the output should contain "was called with no arguments"

  @pending @refresh
  Scenario: Cannot refresh; card not found
    When I run `troo refresh card 69`
    Then the output should contain "Card cannot be found."

  @pending @refresh
  Scenario: Refresh the default card
    Given the Trello API is stubbed with "refresh_card_success"
    And a default card exists
    When I run `troo refresh card`
    Then the output should contain "'My Default Card' refreshed."

  @pending @refresh
  Scenario: Cannot refresh; no default card
    When I run `troo refresh card`
    Then the output should contain "Default card cannot be found."

  @pending @refresh
  Scenario: Cannot refresh, not authenticated with Trello
    Given the Trello API is stubbed with "unauthenticated"

  @pending @refresh
  Scenario: Cannot refresh, Trello not responding
    Given the Trello API is stubbed with "trello_failure"
