Feature: Setting a default card

  @default
  Scenario: Set a card to default
    Given a card exists
    When I run `troo default card 20020`
    Then the output should contain:
      """
      'My Test Card' set as default.
      """

  @default
  Scenario: Cannot set a default; not found
    Given the Trello API is stubbed with "400_card_by_id"
    When I run `troo default card 400`
    Then the output should contain "Card cannot be found."

  @default
  Scenario: Cannot set a default; no ID
    When I run `troo default card`
    Then the output should contain "was called with no arguments"
