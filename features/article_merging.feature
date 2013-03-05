@merging
Feature: Article Merging
  As a blog admin
  In order to consolidate similar blog topics
  I want merge two articles into one

  @spec1
  Scenario: A non-admin cannot merge articles
    Given I am logged in with a 'Non-admin' account
    And I edit article '7'
    Then I will 'not see' 'Merge Articles'
    And I will log out
    Given I am logged in with an 'admin' account
    And I edit article '7'
    Then I will 'see' 'Merge Articles'

  @spec2
  Scenario: Merged article should contain the text of both previous articles
  Given I am logged in with an 'admin' account
  And I edit article '5'
  Then I will 'see' 'Hi everybody <em>!!!'
  And I edit article '7'
  Then I will 'see' 'Hey; I mean, Hi'
  And I merge article '7' to article '5'
  Then I will 'see' 'Hi everybody <em>!!!'
  And I will 'see' 'Hey; I mean, Hi'

