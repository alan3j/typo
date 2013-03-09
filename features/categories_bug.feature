@categories
Feature: Create and edit categories
  As a blog admin
  In order to manage blog categories
  I want to be able to use admin/categories/new

  Background:
    Given the blog is set up
    And I am logged into the admin panel

  Scenario: When I visit admin/categories/new the app works
    Given I go to /admin/categories/new
    Then I will 'see' 'Categories'
