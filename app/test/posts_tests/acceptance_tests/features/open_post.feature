Feature: Open Post
  As a user, when I am on the timeline, when I tap a post card, I should open a post.

  Scenario: Click on a post
    Given I am on the "Timeline"
    And a Post Card exists
    When I tap a "Post Card"
    Then I should be on the "Post Page"







