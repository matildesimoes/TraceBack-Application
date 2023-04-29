Feature: Authentication

  Background:
    Given I am on the initial page
    And I tap the "Login" button
    When I fill the "Email" field with "up202108832@up.pt"
    And I fill the "Password" field with "Ggggg12345"
    And I tap the "Logged" button
    Then I should be navigated to the "Found Timeline"

  Scenario: Lost Timeline
    Given I am on the "Found Timeline"
    And I tap the "Lost" button
    Then I should be navigated to the "Lost Timeline"