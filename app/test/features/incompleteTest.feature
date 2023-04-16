Feature: Authentication

  Background:
    Given I am on the initial page
    When I tap the "Sign Up" button
    Then I should be navigated to the "Sign Page"
  Scenario: Successful sign up
    Given I am on the "Sign Page"
    When I fill the "Name" field with "Nome"
    And I fill the "Email" field with "up202100000@up.pt"
    And I fill the "Phone Number" field with "910000000"
    And I fill the "Password" field with "Password123"
    And I fill the "Password Confirm" field with "Password123"
    And I tap the "Register" button
    Then I should be navigated to the "Profile Page"