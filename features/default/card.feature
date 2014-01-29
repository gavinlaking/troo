Feature: Setting a default card

  Scenario: Set a card to default
    Given a card exists
    When I run `troo --test default card 1`
    Then the output should contain "'My Test Card' set as default card."

  Scenario: Cannot set a default; not found
    When I run `troo --test default card 69`
    Then the output should contain "Card cannot be found."

  Scenario: Cannot set a default; no ID
    When I run `troo --test default card`
    Then the output should contain "was called with no arguments"
