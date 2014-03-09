Feature: Showing the current status

  @status
  Scenario: When there is no local data
    When I run `troo status`
    And the output should contain:
      """
      Status:
        Boards: No boards found.
        Lists:  No lists found.
        Cards:  No cards found.
      """

  @status
  Scenario: When there is local data; all defaults set
    Given local data exists, all defaults set
    When I run `troo status`
    Then the output should contain:
      """
      Status:
        Boards: 1 board found.
                (1) My Default Board *
        Lists:  1 list found.
                (1) My Default List *
        Cards:  1 card found.
                (1) My Default Card *
      """

  @status
  Scenario: When there is local data; some defaults set
    Given local data exists
    When I run `troo status`
    Then the output should contain:
      """
      Status:
        Boards: 2 boards found.
                (1) My Default Board *
        Lists:  1 list found.
                (1) My Default List *
        Cards:  No default card set. (1)
      """

  @status
  Scenario: Reports when local data was last updated
    When I run `troo status`
    Then the output should contain:
      """
      Last refreshed:
      Unknown. Run `troo refresh all`.
      """

  @status
  Scenario: Reports when local data was last updated
    Given local data exists
    When I run `troo status`
    Then the output should not contain:
      """
      Last refreshed:
      Unknown. Run `troo refresh all`.
      """