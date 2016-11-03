# Written by Tommy and Jack
Feature: Document Info Page
  
  As a user
  I want to visit the document information page
  So that I can see and modify a document's information and properties
 
Background: user is on the document repository page
  Given a logged in user
  And a category called "Ctgy"
  And I am on the document repository page 
  When I follow "Add new file"
  Then I fill in "file_title" with "schedule"
  Then I fill in "file_url" with "mock.com/schedule"
  And I select "Ctgy" from "file_category_id"
  And I press "Submit"
  Then I should be on the document repository page
  And I should see "schedule"
  When I follow "schedule"
 
Scenario: Navigates to Info Page for Document
  Then I should be on the doc info page for "schedule"

# Make this scenario more concrete 
Scenario: User should see Updated Time of Document
  Then I should see "Updated At"
  
# happy path
@javascript
Scenario: Admin can edit an existing file
  Given I am logged out
  Given a logged in admin
  And I am on the document repository page
  When I follow "schedule"
  When I follow "Click to Edit Document"
  When I fill in "file_title" with "new schedule"
  When I fill in "file_url" with "mock.com/schedule"
  And I press "Submit"
  Then I should be on the document repository page
  And I should see "new schedule"

Scenario: User cannot edit document
  Then I should not see "Click to Edit Document"

# sad path
@javascript
Scenario: Admin cannot edit an existing file without proper file name
  Given I am logged out
  Given a logged in admin
  And I am on the document repository page
  When I follow "schedule"
  When I follow "Click to Edit Document"
  When I fill in "file_title" with ""
  When I fill in "file_url" with "mock.com/schedule"
  And I press "Submit"
  And I should see "Populate all fields before submission."

Scenario: Should have Not Read as Default
  Then I should see "Not Read" in Read Status Table   

Scenario: Selecting mark as read should change Not Read to Read
  When I check "markasread"
  Then I should see "Read" in Read Status Table 
  
# happy path
@javascript
Scenario: User can delete an announcement
  Given I am logged out
  Given a logged in admin
  And I am on the document repository page
  When I follow "schedule"
  When I press "Delete document"
  And I confirm popup
  Then I should be on the document repository page
  Then I should see "deleted successfully"
  
Scenario: User cannot edit document
  Then I should not see "Delete document"
  
  