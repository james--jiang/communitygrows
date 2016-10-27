Feature: Marking Documents as Read/Unread
  
  As a user
  I want to toggle documents as read/unread
  So that all users knows who has read a document. 
  
  Background:
    Given PENDING
    Given a logged in user
    And I am on the document repository page 
    When I follow "Add new file"
    Then I fill in "file_title" with "schedule"
    Then I fill in "file_url" with "mock.com/schedule"
    And I press "Submit"
    Then I should be on the document repository page
    And I should see "schedule"
    
  Scenario: New File should have status unread
    Then I should see "Unread"
    
  Scenario: User marks a document as read/unread
    Given I should see "Unread"
    When I follow "schedule"
    And I check "Mark as read"
    When I am on the document repository page
    Then I should see "Read"
    When I follow "schedule"
    And I check "Mark as read"
    When I am on the document repository page
    Then I should see "Unread"
  
  Scenario: I can see who has marked as read
    When I follow "schedule"
    And I check "Mark as read"
    Given a logged in admin
    And I am on the document repository page 
    When I follow "schedule"
    Then I should see "Read"

  Scenario: Only admin should see reset all reads reciepts button
    When I follow "schedule"
    Then I should not see "Reset Read Reciepts"
    Given a logged in admin
    And I am on the document repository page 
    When I follow "schedule"
    Then I should see "Reset Read Reciepts"
    
  Scenario: Admin should be able to reset all reads to unread
    When I follow "schedule"
    And I check "Mark as read"
    Given a logged in admin
    And I am on the document repository page 
    When I follow "schedule"
    Given I click "Reset Read Reciepts"
    Then I should not see "Read"

  Scenario: Checkbox should be checked after exiting the page
    When I follow "schedule"
    And I check "Mark as read"
    And I am on the document repository page
    When I follow "schedule"
    Then the "Mark as read" checkbox should be checked
    
    
    
    