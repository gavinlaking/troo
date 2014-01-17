Feature: Ascertaining the version of Troo.

Scenario:
  When I run `troo version`
  Then the output should contain:
  """
  troo 0.0.2
  """
