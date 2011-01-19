Feature: Select text via command shortcuts
  In order to select blocks of text quickly
  As a user
  I want more keybindings

  Background:
    Given I have opened "features/fixtures/test.rb"
    When I insert "This is so fly!\nWait no!\nJane,\nstop this crazy thing!" at the cursor
    And I move the cursor to 7
    And I open vimly mode

  Scenario: Selecting words
    When I type "s3w"
    And I submit the vimly command
    Then the selected text should be "is so fly"

  Scenario: Selecting letters
    When I type "s5c"
    And I submit the vimly command
    Then the selected text should be " so f"

  Scenario: Selecting lines
    And I type "s2l"
    And I submit the vimly command
    Then the selected text should be " so fly!\nWait no!"
    When I move the cursor to 0
    And I type "s2l"
    And I submit the vimly command
    Then the selected text should be "This is so fly!\nWait no!"