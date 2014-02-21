Feature: Moving a card

  @move
  Scenario: Move a card to another list
    Given the Trello API is stubbed with "200_move_card_200_list"
    #Given a card exists
    #And a list exists
    When I run `troo move 200 200`
    Then the output should contain:
      """
      Card 'My Test Card' moved to 'My Test List'.
      """

  @move
  Scenario: Cannot move card, card not found
    Given the Trello API is stubbed with "400_move_card_200_list"
    When I run `troo move 400 200`
    Then the output should contain:
      """
      Card cannot be found.
      """

  @move
  Scenario: Cannot move card, list not found
    Given the Trello API is stubbed with "400_move_card_400_list"
    When I run `troo move 200 400`
    Then the output should contain:
      """
      List cannot be found.
      """

  @move
  Scenario: Move a card to another list (different board)
    Given the Trello API is stubbed with "200_move_card_200_board"
    When I run `troo move 200 200 200`
    Then the output should contain:
      """
      Card 'My Test Card' moved to 'My Test List' on 'My Test Board'.
      """

  @move
  Scenario: Cannot move card, board not found
    Given the Trello API is stubbed with "400_move_card_400_board"
    When I run `troo move 200 200 400`
    Then the output should contain:
      """
      Board cannot be found.
      """
