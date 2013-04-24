require 'pry'

Given /^I run with Watir$/ do
  require 'watir'
  require 'win32ole'
  $ai          = ::WIN32OLE.new('AutoItX3.Control')
  $first_index = 1
  $watir_script = true
end

Given /^I run with Classic Watir$/ do
  step "I run with Watir$"
end

Given /^I run with Watir-webdriver$/i do
  require 'watir-webdriver'
  $first_index = 0
  $watir_script = false
end


When /^I open a new browser$/i do
  if @params
    case @params["browser"]
      when "FF"
        @browser = Watir::Browser.new :firefox
      when "IE"
        step "I open an internet explorer browser"
      when "C", "GC"
        @browser = Watir::Browser.new :chrome
    end
  else
    @browser = Watir::Browser.new
  end
end


Given /^I open a firefox browser$/i do
  @browser = Watir::Browser.new :firefox
end

Given /^I open a chrome browser$/i do
  @browser = Watir::Browser.new :chrome
end

When /^I open an IE browser$/i do
  step "I open an internet explorer browser"
end

Given /^I open an internet explorer browser$/i do
  if $watir_script
    @browser       = Watir::IE.new
    @browser.speed = :fast
  else
    client         = Selenium::WebDriver::Remote::Http::Default.new
    client.timeout = 300 # seconds – default is 60
    @browser       = Watir::Browser.new :ie, :http_client => client
  end
end

Then /^I navigate to the environment url$/ do
  url = @params['environment']['url']
  @browser.goto url
end

Then /^I go to the url "(.*?)"$/ do |url|
  @browser.goto url
end

Then /^I click "(.*?)"$/ do |element_text|
	step "I wait 1 second"
  step "I click the element with \"text\" \"#{element_text}\""
end

Then /^I click the button "(.*?)"$/ do |element_text|
  step "I wait 1 second"
  @browser.button(:text, element_text).click
end

Then /^I click the element with "(.*?)" "(.*?)"$/ do |how, what|
  element = @browser.element(how.to_sym, what)
  if element.respond_to?("click")
    element.click
  else
    fail("Element with #{how} '#{what}' does not respond to 'click'")
  end
end

Then /^I should see "(.*?)"$/ do |text|
  step "I wait 1 second"
  unless @browser.text.include? text
    fail("Did not find text #{text}")
  end
end

Then /^I should not see "(.*?)"$/ do |text|
  if @browser.text.include? text
    fail("Found text #{text}")
  end
end


Then /^I fill in "(.*?)" with "(.*?)"$/ do |field, value| #assumes u have label
  associated_label = @browser.label(:text, field).attribute_value("for")
  #associated_label = @browser.element(:xpath, '//label[contains(text(),"#{arg1}")]').attribute_value("for"))
  @browser.text_field(:id, associated_label).set value
end

Then /^let me debug$/ do
  binding.pry
end

When /^I wait (\d+) seconds?$/ do |seconds|
  sleep seconds.to_i
end

Before do
  manifest_file = File.join(File.dirname(__FILE__), '..', 'manifest.json')
  @params = JSON.parse(File.open(manifest_file).read)['params'] #Have access to all params in manifest file
end
