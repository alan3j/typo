Feature: Article Merging
  As a blog admin
  In order to consolidate similar blog topics
  I want merge two articles into one

  Scenario: First of two similar articles is shown
    Given I am on the article_view page for 'Article_1'
    Then I should see article_id '101'
    And content saying 'Oklhaoma City'

  Scenario: Second of two similar articles is shown
    Given I am on the article_view page for 'Article_2'
    Then I should see article_id '102'
    And content saying 'Tulsa'

  Scenario: Merge article - admin check part 1
    Given I am on the edit_page for article_id '101'
    And I am the admin
    Then I should see the merge_article form

  Scenario: Merge article - admin check part 2
    Given I am on the edit_page for article_id '101'
    And I am not the admin
    Then I should not see the merge_article form

  Scenario: Merge article ID 102 into article ID 101
    Given I am on the edit page for article_id '101'
    And I am the admin
    And I submit the merge_article form with article_id equal '102'
    Then I should be on the article_view page for 'Article_1'
    And I should see 'all the specificatons (write more foo)'


