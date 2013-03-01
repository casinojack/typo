Feature: Merge Articles
  As a blog administrator
  In order to remove duplication of article content
  I want to be able to merge two closely related articles

  Background:
    Given the blog is set up
    And the following articles exist:
      | title     | author   | body   | id   |
      | Article 1 | Author 1 | Body 1 | 1    |
      | Article 2 | Author 2 | Body 2 | 2    |
    And the following users exist:
      | login     | name           | password  | email               | profile_id |
      | Admin     | Blog Admin     | Admin     | Admin@email.com     | 1          |
      | Non-Admin | Blog Publisher | Non-Admin | Non-Admin@email.com | 2          |
#    And the following comments exist:
#      | title     | article_id | author      | body |
#      | Comment 1 | 1          | Commenter 1 | cb1  |
#      | Comment 2 | 2          | Commenter 2 | cb2  |
#      | Comment 3 | 3          | Commenter 3 | cb3  |
  
  Scenario: Admins can merge articles
    Given I am logged into the admin panel as "Admin"
    And I am on the edit article page for "Article 1"
    Then I should see "Merge Articles"

  Scenario: non-Admins cannot merge articles
    Given I am logged into the admin panel as "Non-Admin"
    And I am on the edit article page for "Article 1"
    Then I should not see "Merge Articles"

  Scenario: the merged article should contain the text of both previous articles
    Given I am logged into the admin panel as "Admin"
    And I am on the edit article page for "Article 1"
    When I merge the article with "Article 2"
    Then I should see "Body 1"
    And I should see "Body 2"

#  Scenario: the merged article should have one author
#    Given I am logged into the admin panel as "Admin"
#    And I am on the edit article page for "Article 1"
#    When I merge the article with "Article 2"
#    Then I should see "Author 1"
#    And I should not see "Author 2"
#
#  Scenario: the merged article should keep the original comments
#    Given I am logged into the admin panel as "Admin"
#    And I am on the edit article page for "Article 1"
#    When I merge the article with "Article 2"
#    Then I should see "Comment 1"
#    And I should see "Comment 2"
#    And I should not see "Comment 3"
#
#  Scenario: the merged article should have the title of one of the original articles
#    Given I am logged into the admin panel as "Admin"
#    And I am on the edit article page for "Article 1"
#    When I merge the article with "Article 2"
#    Then I should see "Article 1"
#    And I should not see "Article 2"
