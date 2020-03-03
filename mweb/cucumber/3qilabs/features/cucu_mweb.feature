Feature: Test Cucumber script
	I want to test cucumber

Scenario: TestScenario1
	Given I connect to the address
        Then I wait 5 seconds
<<<<<<< HEAD
	Then I go to the url "http://google.com"
=======
Then I go to the url "https://google.co.in/"
>>>>>>> b2cc1ee8ccb6d8cca70ee1daa21a8dfc817ae363
        Then I wait 5 seconds
	Then I fill in with value "3qilabs"
	Then I click the search button "btnG"
        Then I wait 5 seconds
	Then I should see "3Qi"