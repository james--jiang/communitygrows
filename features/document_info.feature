# Written by Tommy and Jack
Feature: Document Info Page
  
  As a user
  I want to visit the document information page
  So that I can see and modify a document's information and properties
 
Background: user is on the document repository page
  Given a logged in user
  And I am on the document repository page 
  When I follow "Add new file"
  Then I fill in "file_title" with "schedule"
  Then I fill in "file_url" with "mock.com/schedule"
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
Scenario: User can edit an existing file
  When I fill in "file_title" with "new schedule"
  When I fill in "file_url" with "mock.com/schedule"
  And I press "Submit"
  Then I should be on the document repository page
  And I should see "new schedule"

# sad path
Scenario: User cannot edit an existing file without proper file name
  When I fill in "file_title" with ""
  When I fill in "file_url" with "mock.com/schedule"
  And I press "Submit"
  And I should see "Populate all fields before submission."

# happy path
@javascript
Scenario: User can delete an announcement
  When I follow "Delete document"
  And I confirm popup
  # Then I should be on the document repository page
  Then I should see "deleted successfully"
  
  