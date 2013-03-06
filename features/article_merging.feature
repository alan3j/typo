@merging
Feature: Article Merging (new)
  As a blog admin
  In order to consolidate similar blog topics
  I want merge two articles into one

  Background:
    Given the blog is set up
    And I am logged into the admin panel
    And I have added my test user accounts
    And I have added my test articles
    Then I will log out

  @spec1
  Scenario: A non-admin cannot merge two articles
    Given I am logged in with a 'Non-admin' account
    And I edit article '7'
    Then I will 'not see' 'Merge Articles'
    And I will log out
    Given I am logged in with an 'admin' account
    And I edit article '7'
    Then I will 'see' 'Merge Articles'

  @spec2
  Scenario: When articles are merged, the merged article should contain the text of both previous articles
    Given I am logged in with an 'admin' account
    And I edit article '5'
    Then I will 'see' 'Hi everybody <em>!!!'
    And I edit article '7'
    Then I will 'see' 'Hey; I mean, Hi'
    And I merge article '7' to article '5'
    Then I will 'see' 'Hi everybody <em>!!!'
    And I will 'see' 'Hey; I mean, Hi'

  @spec3
  Scenario: When articles are merged, the merged article should have one author
    Given I am logged in with an 'admin' account
    And I edit article '5'
    And I merge article '7' to article '5'
    Then Article '5' will have author 'testadmin'

  @spec4
  Scenario: Comments of the original articles need to all carry over and point to the new, merged article
    Given I am logged in with an 'admin' account
    And I edit article '5'
    And I merge article '7' to article '5'
    Then Article '5' will have '4' comments

  @spec5
  Scenario: The title of the new article should be the title from either one of the merged articles
    Given I am logged in with an 'admin' account
    And I edit article '5'
    And I merge article '7' to article '5'
    Then Article '5' will have title 'Admin says hi'



