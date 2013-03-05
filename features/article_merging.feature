Feature: Article Merging
  As a blog admin
  In order to consolidate similar blog topics
  I want merge two articles into one

  Scenario: A non-admin cannot merge articles
    Given I am logged in with a 'Non-admin' account
    And I edit article '7'
    Then I will 'not see' 'Merge Articles'
    And I will log out
    Given I am logged in with an 'admin' account
    And I edit article '7'
    Then I will 'see' 'Merge Articles'


