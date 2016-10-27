Feature: successfully CRUD on the document repository
  
  As a user
  I want to perform CRUD actions on the document repository
  So that I can not only access the information but contribute to them

Background: user is on the document repository page
  
  Given a logged in user
  And I am on the document repository page

# happy path
Scenario: User can add a new document
  When I follow "Add new file"
  Then I fill in "file_title" with "schedule"
  Then I fill in "file_url" with "mock.com/schedule"
  And I press "Submit"
  Then I should be on the document repository page
  And I should see "schedule"

# sad path
Scenario: User can't add a new document without proper file name
  When I follow "Add new file"
  Then I fill in "file_url" with "mock.com/schedule"
  And I press "Submit"
  And I should see "Populate all fields before submission."
  
Scenario: I should see the read/unread column
  # Column name is Read/Unread? for now
  Given PENDING
  Then I should see "Read/Unread?"

Scenario: see six categories
  When I am on the document repository page
  Then I should see "About Community Grows"
  Then I should see "Board Overview"
  Then I should see "Board Activities"
  Then I should see "Budgets and Finances"
  Then I should see "AB Meetings"
  Then I should see "Board Resources"
  

  
