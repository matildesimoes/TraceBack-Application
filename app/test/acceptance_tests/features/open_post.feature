Feature: Open Post
  As a user, when I am on the timeline, when I tap a post card, I should open a post.

  Background:
    Given I am on the initial page
    And I tap the "Login" button
    When I fill the "Email" field with "up202108760@up.pt"
    And I fill the "Password" field with "Pass12345"
    And I tap the "Logged" button
    Then I should be navigated to the "Found Timeline"

  Scenario: Click on a post
    Given a Post Card exists
    When I tap a "Post Card"
    Then I should be on the "Post Page"







