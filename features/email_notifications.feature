Feature: Users should receive email notifications

	As a user,
	I want to receive notifications when and admin makes changes,
	So that I can stay updated with the organization

Background: users in database
  
  Given the following users exist:
    | email                    | admin      | created_at           | password     | password_confirmation     |
    | james@gmail.com          | true       | 2016-03-17 17:44:13  | 12341234     | 12341234                  |
    | elmer@gmail.com          | false      | 2016-03-14 15:32:00  | 43124312     | 43124312                  |
    | uglytommy@berkeley.edu   | false      | 2016-03-18 22:12:11  | 54175417     | 54175417                  |

  Given a logged in user
  And I am on the dashboard page

Scenario: An email should be sent if anyone makes an announcement to the internal subcommittee
  Given I am on the Internal Subcommittee page
  And I make a new announcement
  And I press "Submit" 
  Then I should see "Emails sent to subcommittee members"

Scenario: An email should be sent if anyone makes an announcement to the external subcommittee
  Given I am on the External Subcommittee page
  And I make a new announcement
  And I press "Submit" 
  Then I should see "Emails sent to subcommittee members"

Scenario: An email should be sent if anyone makes changes to a document to the internal subcomittee
  Given I am on the Internal Subcommittee page
  And I make a new document
  And I press "Submit" 
  Then I should see "Emails sent to subcommittee members"

Scenario: An email should be sent if anyone makes changes to a document to the external subcomittee
  Given I am on the External Subcommittee page
  And I make a document
  And I press "Submit" 
  Then I should see "Emails sent to subcommittee members"

Scenario: An email should be sent if anyone makes changes to a document to the external subcomittee
  Given I am on the External Subcommittee page
  And I edit a new document
  And I press "Submit" 
  Then I should see "Emails sent to subcommittee members"

Scenario: An email should be sent if anyone makes changes to a document to the interal subcomittee
  Given I am on the Internal Subcommittee page
  And I edit an announcement
  And I press "Submit" 
  Then I should see "Emails sent to subcommittee members"

Scenario: An email should be sent if an admin makes changes to new event
  Given a logged in admin
  And I am on the CommunityGrows admin_dashboard page
  And I create a new event  
  Then I should see "Emails sent to subcommittee members"

Scenario: An email should be sent if an admin makes changes to meeting location
  Given a logged in admin
  And I am on the CommunityGrows admin_dashboard page
  And I update event location
  Then I should see "Emails sent to subcommittee members"
