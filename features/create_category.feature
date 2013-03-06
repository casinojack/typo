Feature: Create Category
  As an author
  In order to manage my articles
  I want to be able to create categories to file my articles

  Background:
    Given the blog is set up
    And I am logged into the admin panel
    And the following categories exist:
      | name       |
      | Category 1 |
      | Category 2 |

  Scenario: Create category page shown
    Given I am on the manage categories page
    Then I should see "Category 1"
    And I should see "Category 2"

  Scenario: Create a new category
    Given I am on the manage categories page
    And I fill in "category_name" with "TestCategory"
    And I press "Save"
    Then I should see "Category was successfully saved"
    And I should see "TestCategory"

  Scenario: Edit a category
    Given I am on the edit category page for "Category 2"
    And I fill in "category_name" with "Category 3"
    And I press "Save"
    Then I should see "Category was successfully saved"
    And I should see "Category 3"
    And I should not see "Category 2"

  Scenario: Delete a category
    Given I am on the manage categories page
    When I delete the category "Category 1"
    Then I should not see "Category 1"
    And I should see "Category 2"
  
