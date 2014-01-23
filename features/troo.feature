Feature: Troo basics

Scenario: Running the command with no arguments
  When I run `troo`

Scenario: Getting the current version
  When I run `troo version`
  Then the output should contain:
  """
  troo 0.0.3
  """

Scenario: Getting the current status
  When I run `troo status`
