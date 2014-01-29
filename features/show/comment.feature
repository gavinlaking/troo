Feature: Showing comments
  Background:
    Given a card exists
    And a member exists

  Scenario: Showing comments for a card with ID
    Given a comment exists
    When I run `troo --test show comments 1`
    Then the output should contain "My Test Comment"

  Scenario: Showing comments for a card with ID; no comments
    When I run `troo --test show comments 1`
    Then the output should contain "No comments"

  Scenario: Cannot show comments; card not found
    When I run `troo --test show comments 69`
    Then the output should contain "Card cannot be found."

  Scenario: Showing the comments for the default card
    Given a default card exists
    And a comment exists
    When I run `troo --test show comments`
    Then the output should contain:
      """
       * (67) My Default Card
          gavinlaking1:
          My Test Comment
              (Tue, Dec 17 at 22:01)
      """

  Scenario: Cannot show comments; no default card
    When I run `troo --test show comments`
    Then the output should contain "set a default card first"
