Feature: Test Cucumber script
	I want to test cucumber

Scenario: TestScenario1
        Given I run with Watir
	When I open a new browser
        Then I wait 5 seconds
	Then I go to the url "http://google.com"
	Then I enter "3qilabs" in text field with name "q"
	Then I click the button with "name" "btnG"
	Then I should see "3QI Labs launched in late 2009 with the simple goal of helping development teams"
	Then I close the browser
