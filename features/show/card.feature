Feature: Showing a card
  Background:
    Given a board exists
    And a list exists
    And a member exists

  @show
  Scenario: Showing a card with ID
    Given a card exists
    When I run `troo show card 1`
    Then the output should contain:
      """
       (67) My Test Card

      Description:
      some description

      Comments:
      No comments have been left.

      Members:
      @gavinlaking1

      Metadata:
         Board:    (1) My Test Board
          List:    (1) My Test List
       Updated: Tue, Dec 17 at 21:48
      """

  @show
  Scenario: Cannot show card; not found
  Given the Trello API is stubbed with "fetch_card_by_id"
    When I run `troo show card 69`
    Then the output should contain "Card cannot be found."

  @show
  Scenario: Showing the default card
    Given a default card exists
    When I run `troo show card`
    Then the output should contain:
      """
      * (67) My Default Card

      Description:
      some description

      Comments:
      No comments have been left.

      Members:
      @gavinlaking1

      Metadata:
         Board:    (1) My Test Board
          List:    (1) My Test List
       Updated: Tue, Dec 17 at 21:48
      """

  @show
  Scenario: Cannot show; no default card
    When I run `troo show card`
    Then the output should contain "set a default card first"
