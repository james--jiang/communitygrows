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
  Given "james@gmail.com" logs in with password "12341234"
  And I am on the dashboard page

Scenario: Happy Path

  Given I am on the account details page for "james@gmail.com"

  When I select "Real Time" from "user_digest_pref"
  And I press "Update Digest"
  Then I should see "credentials were successfully updated"
  And I am on the account details page for "james@gmail.com"
  
  Given I am on the account details page for "james@gmail.com"
  When I select "Daily" from "user_digest_pref"
  And I press "Update Digest"
  Then I should see "credentials were successfully updated"
  And I am on the account details page for "james@gmail.com"

  Given I am on the account details page for "james@gmail.com"
   When I select "Weekly" from "user_digest_pref"
  And I press "Update Digest"
  Then I should see "credentials were successfully updated"
  And I am on the account details page for "james@gmail.com"

#   Given I am on the account details page for "james@gmail.com"
#   When I check "real_time"
#   And I check "daily"
#   And I check "weekly"
#   And I press "Confirm"
#   Then I should see "Your email preference settings have been updated."
#   And I am on the account details page for "james@gmail.com"
#   Then the "Real Time:" checkbox should be checked
#   And the "Daily:" checkbox should be checked
#   And the "Weekly:" checkbox should be checked


#   Given I am on the account details page for "james@gmail.com"
#   When I check "daily" 
#   And I check "weekly"
#   And I press "Confirm"
#   Then I should see "Your email preference settings have been updated."
#   And the "daily:" checkbox should be checked
#   And the "weekly:" checkbox should be checked
  
# Scenario: Sad Path
#   Given I am on the account details page for "james@gmail.com"
#   When I uncheck "real_time"
#   And I uncheck "daily"
#   And I uncheck "weekly"
#   And I press "Confirm"
#   Then I should see "Please select your email digest setting."
#   And I am on the account details page for "james@gmail.com"
    
  
  
 
  
  
  