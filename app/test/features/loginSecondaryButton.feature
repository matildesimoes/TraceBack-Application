Feature: Secondary buttons

  Background:
    Given I am on the initial page
    When I tap the "Login" button
    Then I should be navigated to the "Login Page"

  Scenario: Click on secondary signup button
    Given I am on the "Login Page"
    When I tap the "Secondary SignUp" button
    Then I should be navigated to the "Sign Page"


