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
 
Scenario: Navigates to Info Page for Document
  When I follow "schedule"
  Then I should see "Information"
  
# Given the edit/delete options are inside the document info page  
Scenario: Should be able to edit/delete the document inside the info page
  When I follow "schedule"
  And I follow "Edit document"
  Then I fill in "file_title" with "new schedule"
  Then I fill in "file_url" with "mock.com/schedule"
  And I press "Submit"
  Then I should be on the document repository page
  And I should see "new schedule"
  
  # When I follow "new schedule" 
  # And I follow "Delete document"
  # And I confirm popup
  # Then I should be on the document repository page
  # And I should see "deleted successfully"
  
# Scenario: User can edit an existing file
#   When I follow "Add new file"
#   Then I fill in "file_title" with "schedule"
#   Then I fill in "file_url" with "mock.com/schedule"
#   And I press "Submit"
  
#   When I follow "Edit document"
#   Then I fill in "file_title" with "new schedule"
#   Then I fill in "file_url" with "mock.com/schedule"
#   And I press "Submit"
#   Then I should be on the document repository page
#   And I should see "new schedule"

# # sad path
# Scenario: User cannot edit an existing file without proper file name
#   When I follow "Add new file"
#   Then I fill in "file_title" with "schedule"
#   Then I fill in "file_url" with "mock.com/schedule"
#   And I press "Submit"
#   When I follow "Edit document"
#   Then I fill in "file_title" with ""
#   Then I fill in "file_url" with "mock.com/schedule"
#   And I press "Submit"
#   And I should see "Populate all fields before submission."

# # happy path
# @javascript
# Scenario: User can delete an announcement
#   When I follow "Add new file"
#   Then I fill in "file_title" with "delete schedule"
#   Then I fill in "file_url" with "mock.com/schedule"
#   And I press "Submit"
#   When I follow "Delete document"
#   And I confirm popup
#   Then I should be on the document repository page
#   And I should see "deleted successfully"
  
  