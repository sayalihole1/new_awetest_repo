##upated

Then(/^I enter text "(.*?)" in the search box$/) do |arg1|
  @browser.text_field(:id,'gbqfq').set("#{arg1}")
end

Then(/^I click the search button$/) do
  @browser.button(:id,'gbqfb').click
end

Then(/^I click the link with text "(.*?)"$/) do |text|
  @browser.link(:text, "#{text}").click
end

