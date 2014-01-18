Feature: Troo basics

Scenario: Running the command for the first time
  When I run `troo`

Scenario: Running the command with no arguments
  When I run `troo`

Scenario: Getting the current version
  When I run `troo version`
  Then the output should be the version number of troo

Scenario: Getting the current status
  When I run `troo status`
