Feature: Showing the current status

  Scenario: When there is no local data
    When I run `troo --test status`
    And the output should contain:
      """
      Status:
        Boards: No boards found.
        Lists:  No lists found.
        Cards:  No cards found.
      """

  Scenario: When there is local data; all defaults set
    Given a default board exists
    And a default list exists
    And a default card exists
    When I run `troo --test status`
    Then the output should contain:
      """
      Status:
        Boards: 1 board found.
                * (1) My Default Board
        Lists:  1 list found.
                * (1) My Default List
        Cards:  1 card found.
                * (67) My Default Card
      """

  Scenario: When there is local data; some defaults set
    Given a default board exists
    And a board exists
    And a default list exists
    And a card exists
    When I run `troo --test status`
    Then the output should contain:
      """
      Status:
        Boards: 2 boards found.
                * (1) My Default Board
        Lists:  1 list found.
                * (1) My Default List
        Cards:  No default card set.
      """
