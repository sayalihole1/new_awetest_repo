require 'pry'

When /^I open a browser$/i do
  if @params
    case @params["browser"]
      when "FF"
        step "I open Firefox"
      when "IE"
        step "I open Internet Explorer"
      when "C", "GC"
        step "I open Chrome"
end
  else
    step "I open Firefox"
  end
end

And /^I click the "(.+?)" button$/ do |value|
  step "I click the button with value \"#{value}\""
end

Then /^I click the element with "?(.+?)"? "(.+?)"$/ do |how, what|
  what = Regexp.new(Regexp.escape(what)) unless how =~ /index|text/i or what.is_a?(Regexp)
  @browser.element(how.to_sym, what).click
end

#And /^I enter "(.*?)" in text field with "?(.+?)"? "(.*?)"$/ do |value, how, what|
#  what = Regexp.new(Regexp.escape(what)) unless how =~ /index|text/i or what.is_a?(Regexp)
#  @browser.text_field(how.to_sym, what).set(value)
#end

Then /^I check that the span with "?(.+?)"? "(.*?)" contains the account name$/ do |how, what|
  what = Regexp.new(Regexp.escape(what)) unless how =~ /index|text/i or what.is_a?(Regexp)
  @browser.span(how.to_sym, what).text == @account_name
end


