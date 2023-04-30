Feature: Timeline testing

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

  Scenario: Create Found Post
    Given I am on the "Found Timeline"
    And I tap the "Create" button
    Then I should be navigated to the "Create Found Post"

  Scenario: Create Lost Post
    Given I am on the "Found Timeline"
    And I tap the "Lost" button
    And I tap the "Create" button
    Then I should be navigated to the "Create Lost Post"