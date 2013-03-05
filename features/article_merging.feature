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


