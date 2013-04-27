Feature: Bookcamp Cucumber 0

  Scenario: Sign in, add and delete a new account, and sign out
    Given I open a new browser
    Then I go to the url "https://accounts.zoho.com/login?serviceurl=https://www.zoho.com/&hide_signup=true&css=https://www.zoho.com/css/login.css"
      And sleep for 2 seconds

    Then I enter "joeklienwatir@gmail.com" in text field with id "lid"
      And I enter "watir001" in text field with name "pwd"
      And I click the button with "value" "Sign In"
      And sleep for 2 seconds

    Then I click the link with "title" "CRM Software"
      And sleep for 4 seconds
    Then I click the link with "id" "tab_Accounts"
      And sleep for 2 seconds

    Then I create a unique account name
    Then I click the button with "value" "New Account"
      And sleep for 2 seconds
      And I enter "Bootcamp 0" in text field with name "Account Name"
      And I click the button with "value" "Save"
      And sleep for 2 seconds

    Then I should see "Bootcamp 0"
      And sleep for 2 seconds
    Then I click the link with "id" "tab_Accounts"
      And sleep for 2 seconds
      And I should see "Bootcamp 0"
      And sleep for 2 seconds

    Then I click the link with "text" "Bootcamp 0"
      And sleep for 4 seconds
      And I click the button with "name" "Delete2"
      And sleep for 2 seconds
      And I click "OK" in the browser alert
      And sleep for 2 seconds
      And I should not see "Bootcamp 0"

    Then I click the div with "id" "linkid"
      And I click the button with "value" "Sign Out"
      And sleep for 2 seconds
    Then I close the browser
