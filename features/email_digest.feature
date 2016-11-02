Feature: Users are able to decide their email preferences

    As a user
    I want to update my email preference settings
    So that I can receive the emails I want to receive and not be overloaded with emails.
    
Background: users in databse
  
  Given the following users exist:
    | email                    | admin      | created_at           | password     | password_confirmation     | internal     | external      | executive   |          
    | james@gmail.com          | true       | 2016-03-17 17:44:13  | 12341234     | 12341234                  |    false     |   true      |     true    |
    | elmer@gmail.com          | false      | 2016-03-14 15:32:00  | 43124312     | 43124312                  |    true      |   false      |     true    |
    | uglytommy@berkeley.edu   | false      | 2016-03-18 22:12:11  | 54175417     | 54175417                  |    false     |   false      |     false   |
    # | email             | admin      | created_at           | password     | password_confirmation     |
    # | zach@gmail.com    | true       | 2016-03-17 17:44:13  | 12341234     | 12341234                  |
    # | tonylee@gmail.com | false      | 2016-03-14 15:32:00  | 43124312     | 43124312                  |
    # | jae@berkeley.edu  | false      | 2016-03-18 22:12:11  | 54175417     | 54175417                  |
Scenario: Happy Path
  Given I am on the account details page for "james@gmail.com"
  When I check "internal"
  And I press "Confirm"
  Then I am on the account details page
  And I should see "Your email preference settings have been updated."
  And I should receive: "internal" email
  
  Given I am on the account details page for "james@gmail.com"
  When I check the following preferences: "internal", "executive"
  And I press "Confirm"
  Then I am on the account details page for "james@gmail.com"
  And I should see "Your email preference settings have been updated."
  And I should receive: internal, executive email
  
  Given I am on the account details page for "james@gmail.com"
  When I check "external"
  And I press "Confirm"
  Then I am on the account details page for "james@gmail.com"
  And I should see "Your email preference settings have been updated."
  And I should receive: "external" email
  
  Given I am on the account details page for "james@gmail.com"
  When I check the following preferences: "internal", "external", "executive"
  And I press "Confirm"
  Then I am on the account details page for "james@gmail.com"
  And I should see "Your email preference settings have been updated."
  And I should receive: "internal", "external", "executive" email
  
  Given I am on the account details page for "james@gmail.com"
  When I check the following preferences: "external", "executive"
  And I press "Confirm"
  Then I am on the account details page for "james@gmail.com"
  And I should see "Your email preference settings have been updated."
  And I should receive: "external", "executive" email
  
Scenario: Sad Path
  Given I am on the account details page for "james@gmail.com"
  When I check " "
  And I press "Confirm"
  Then I am on the account details page
  And I should see "Please select at least your committee to receive emails from."
    
  
  
 
  
  
  