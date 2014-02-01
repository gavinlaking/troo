Feature: Showing comments
  Background:
    Given a card exists
    And a member exists

  @show
  Scenario: Showing comments for a card with ID
    Given a comment exists
    When I run `troo show comments 1`
    Then the output should contain "My Test Comment"

  @show
  Scenario: Showing comments for a card with ID; no comments
    When I run `troo show comments 1`
    Then the output should contain "No comments"

  @show
  Scenario: Cannot show comments; card not found
    When I run `troo show comments 69`
    Then the output should contain "Card cannot be found."

  @show
  Scenario: Showing the comments for the default card
    Given a default card exists
    And a comment exists
    When I run `troo show comments`
    Then the output should contain:
      """
       * (67) My Default Card
          gavinlaking1:
          My Test Comment
              (Tue, Dec 17 at 22:01)
      """

  @show
  Scenario: Cannot show comments; no default card
    When I run `troo show comments`
    Then the output should contain "set a default card first"
