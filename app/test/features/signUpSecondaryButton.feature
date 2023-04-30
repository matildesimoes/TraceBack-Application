Feature: Secondary buttons

  Background:
    Given I am on the initial page
    When I tap the "Sign Up" button
    Then I should be navigated to the "Sign Page"

Scenario: Click on secondary login button
    Given I am on the "Sign Page"
    When I tap the "Secondary Login" button
    Then I should be navigated to the "Login Page"