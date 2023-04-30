Feature: Authentication

  Background:
    Given I am on the initial page
    When I tap the "Login" button
    Then I should be navigated to the "Login Page"
  Scenario: Successful log in
    Given I am on the "Login Page"
    When I fill the "Email" field with "up202108832@up.pt"
    And I fill the "Password" field with "Ggggg12345"
    And I tap the "Logged" button
    Then I should be navigated to the "Found Timeline"

