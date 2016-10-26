Feature: Category Management
  
  As an admin
  I want to add, remove, edit, hide, or show categories
  So that documents can be sorted more effectively
  
Background: admin is on the admin dashboard and a category has been created
  Given PENDING
  Given a logged in admin
  And I am on the category management page
  Then I should see "New Category"
  When I follow "New Category"
  And I fill in "Category Name" with "new category"
  And I press "Submit"

# happy path
Scenario: should be able to add a category
  Then I should see "new category"


# happy path
Scenario: should be able to edit a created category
  Then I should see "Edit Category"
  When I follow first "Edit Category"
  And I fill in "Category Name" with "CATegory"
  And I press "Submit"
  Then I should see "CATegory"

# sad path
@javascript
Scenario: should not be able to edit category names to be blank
  Then I should see "Edit Category"
  When I follow first "Edit Category"
  And I fill in "Category Name" with ""
  And I press "Submit"
  Then I should see "Please fill out this field."

# happy path
@javascript
Scenario: should be able to delete a created category
  Then I should see "Delete Category"
  When I follow first "Delete Category"
  And I confirm popup
  Then I should not see "new category"

# happy path
Scenario: should be able to hide a category
  Then I should see "Hide Category"
  When I follow first "Hide Category"
  And I am on the document repository page
  Then I should not see "new category"

# happy path
Scenario: should be able to show a hidden category
  Then I should see "Hide Category"
  When I follow first "Hide Category"
  And I am on the document repository page
  Then I should not see "new category"
  When I am on the category management page
  Then I should see "Show Category"
  When I follow first "Show Category"
  And I am on the document repository page
  Then I should see "new category"

# no sad path because the design of CRUD is specifically open to the admin's discretion
