Feature: Showing a list

  @show
  Scenario: Showing a list with ID
    Given a list exists
    When I run `troo show list 20040`
    Then the output should contain:
      """
      (1) My Test Board

          (1) My Test List

              No cards were found.
      """

  @show
  Scenario: Cannot show list; not found
    Given the Trello API is stubbed with "400_list_by_id"
    When I run `troo show list 400`
    Then the output should contain:
      """
      List cannot be found.
      """

  @show
  Scenario: Showing the default list
    Given a default list exists
    When I run `troo show list`
    Then the output should contain:
      """
      (1) My Test Board

          (1) My Default List *

              No cards were found.
      """

  @show
  Scenario: Cannot show; no default list
    When I run `troo show list`
    Then the output should contain:
    """
    set a default list first
    """
