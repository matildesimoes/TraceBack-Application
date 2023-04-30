Feature: Open Post
  As a user, when I am on the timeline, when I tap a post card, I should open a post.

  Scenario: Only see Found Posts
    Given I am on the "Timeline"
    When I tap the "Found Button" on the navigation bar
    Then I should be on the "Found Timeline"
    And I should not see "Lost Post Card"s

  Scenario: Switch timeline and Only see Lost Posts
    Given I am on the "Timeline"
    When I tap the "Lost Button" on the navigation bar
    Then I should be on the "Lost Timeline"
    And I should not see "Found Post Card"s







