Feature: Showing a list
  Background:
    Given a board exists
    And a card exists

  Scenario: Showing a list with ID
    Given a list exists
    When I run `troo --test show list 1`
    Then the output should contain:
      """
       (1) My Test Board
           (1) My Test List
           (67) My Test Card
      """

  Scenario: Cannot show list; not found
    When I run `troo --test show list 69`
    Then the output should contain "List cannot be found."

  Scenario: Showing the default list
    Given a default list exists
    When I run `troo --test show list`
    Then the output should contain:
      """
       (1) My Test Board
          * (1) My Default List
           (67) My Test Card
      """

  Scenario: Cannot show; no default list
    When I run `troo --test show list`
    Then the output should contain "set a default list first"
