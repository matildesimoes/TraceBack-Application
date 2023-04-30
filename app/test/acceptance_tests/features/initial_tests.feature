Feature: Initial Page
  As a user I want to see the initial page so that I can either log in or sign up

  Scenario: Click on login button
    Given I am on the initial page
    When I tap the "Login" button
    Then I should be navigated to the "Login Page"

  Scenario: Click on sign up button
    Given I am on the initial page
    When I tap the "Sign Up" button
    And I should be navigated to the "Sign Page"










