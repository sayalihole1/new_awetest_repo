require 'pry'
@timestamp     = Time.now.strftime("%Y%m%d%H%M%S")

#Given /^I run with Watir$/ do
#  require 'watir'
#  require 'win32ole'
#  @ai          = ::WIN32OLE.new('AutoItX3.Control')
#  @first_index = 1
#  @timestamp     = Time.now.strftime("%Y%m%d%H%M%S")
#  $watir_script = true
#end

#Given /^I run with Classic Watir$/ do
#  step "I run with Watir$"
#end

#Given /^I run with Watir-webdriver$/i do
#  require 'watir-webdriver'
#  @first_index = 0
#  @timestamp     = Time.now.strftime("%Y%m%d%H%M%S")
#  $watir_script = false
#end

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

Given /^I open a F?f?irefox B?b?rowser$/i do
  step "I open Firefox"
end

Given /^I open Firefox$/ do
  step "I run with Watir-webdriver"
  @browser = Watir::Browser.new :firefox
end

Given /^I open a C?c?hrome B?b?rowser$/i do
  step "I open Chrome"
end

Given /^I open Chrome$/ do
  step "I run with Watir-webdriver"
  @browser = Watir::Browser.new :chrome
end

When /^I open an IE B?b?rowser$/i do
  step "I open Internet Explorer"
end

Given /^I open an I?i?nternet E?e?xplorer B?b?rowser$/i do
  step "I open Internet Explorer"
end

Given /^I open Internet Explorer$/i do
  #if $watir_script
    step "I run with Watir"
    @browser       = Watir::IE.new
    @browser.speed = :fast
  #else
  #  step "I run with Watir-webdriver"
  #  client         = Selenium::WebDriver::Remote::Http::Default.new
  #  client.timeout = 300 # seconds – default is 60
  #  @browser       = Watir::Browser.new :ie, :http_client => client
  #end
end

And /^I click the "(.+?)" button$/ do |value|
  step "I click the button with value \"#{value}\""
end

Then /^I click the link with "?(.+?)"? "(.+?)"$/ do |how, what|
  what = Regexp.new(Regexp.escape(what)) unless how =~ /index|text/i or what.is_a?(Regexp)
  @browser.link(how.to_sym, what).click
end

Then /^I click the button with "?(.+?)"? "(.+?)"$/ do |how, what|
  what = Regexp.new(Regexp.escape(what)) unless how =~ /index|text/i or what.is_a?(Regexp)
  @browser.button(how.to_sym, what).click
end

Then /^I click the div with "?(.+?)"? "(.+?)"$/ do |how, what|
  what = Regexp.new(Regexp.escape(what)) unless how =~ /index|text/i or what.is_a?(Regexp)
  @browser.div(how.to_sym, what).click
end

Then /^I click the element with "?(.+?)"? "(.+?)"$/ do |how, what|
  what = Regexp.new(Regexp.escape(what)) unless how =~ /index|text/i or what.is_a?(Regexp)
  @browser.element(how.to_sym, what).click
end

And /^I enter "(.*?)" in text field with "?(.+?)"? "(.*?)"$/ do |value, how, what|
  what = Regexp.new(Regexp.escape(what)) unless how =~ /index|text/i or what.is_a?(Regexp)
  @browser.text_field(how.to_sym, what).set(value)
end

And /^I enter the value for "(.*?)" in text field with "?(.+?)"? "(.*?)"$/ do |index, how, what|
  if index =~ /zipcode/
    value = @var[index].to_i.to_s
  else
    value = @var[index]
  end
  @browser.text_field(how.to_sym, what).set(value)
end

And /^I select the value for "(.*?)" in select list with "?(.+?)"? "(.*?)"$/ do |index, how, what|
  what = Regexp.new(Regexp.escape(what)) unless how =~ /index|text/i or what.is_a?(Regexp)
  value = @var[index]
  @browser.select_list(how.to_sym, what).select(value)
end

Then /^I check that the span with "?(.+?)"? "(.*?)" contains the account name$/ do |how, what|
  what = Regexp.new(Regexp.escape(what)) unless how =~ /index|text/i or what.is_a?(Regexp)
  @browser.span(how.to_sym, what).text == @account_name
end

Then /^I check that the text field with "?(.+?)"? "(.*?)" contains the value for "(.*?)"$/ do |how, what, index|
  if index =~ /zipcode/
    value = @var[index].to_i.to_s
  else
    value = @var[index]
  end
  what = Regexp.new(Regexp.escape(what)) unless how =~ /index|text/i or what.is_a?(Regexp)
  unless @browser.text_field(how.to_sym, what).value.include?(value)
    fail("The text field with #{how} '#{what}' does not contain the value for '#{index}' ('#{value}')")
  end
end

And /^I click "(.*?)" in the browser alert$/ do |button|
  if $watir_script
    @ai.WinWait("Message from webpage")
    sleep(1)
    @ai.ControlClick("Message from webpage", "", button)
  else
    @browser.alert.wait_until_present
    case button
      when /ok/i, /yes/i, /submit/i
        @browser.alert.ok
      when /cancel/i, /close/i
        @browser.alert.close
      else
        fail("'#{button} for alert not recognized.")
    end
  end
end

And /^I close the browser$/ do
  @browser.close
end

Given /^I load data spreadsheet "(.*?)" for "(.*?)"$/ do |file, feature|
  require 'roo'
  @workbook               = Excel.new(file)
  @feature_name           = feature     #File.basename(feature, ".feature")
  step "I load @login from spreadsheet"
  step "I load @var from spreadsheet"
end

Then /^I load @login from spreadsheet$/ do
  @login                 = Hash.new
  @workbook.default_sheet = @workbook.sheets[0]

  script_col   = 0
  role_col     = 0
  userid_col   = 0
  password_col = 0
  url_col      = 0
  name_col     = 0

  1.upto(@workbook.last_column) do |col|
    header = @workbook.cell(1, col)
    case header
      when @feature_name
        script_col = col
      when 'role'
        role_col = col
      when 'userid'
        userid_col = col
      when 'password'
        password_col = col
      when 'url'
        url_col = col
      when 'name'
        name_col = col
    end
  end

  2.upto(@workbook.last_row) do |line|
    role     = @workbook.cell(line, role_col)
    userid   = @workbook.cell(line, userid_col)
    password = @workbook.cell(line, password_col)
    url      = @workbook.cell(line, url_col)
    username = @workbook.cell(line, name_col)
    enabled  = @workbook.cell(line, script_col).to_s

    if enabled == 'Y'
      @login['role']     = role
      @login['userid']   = userid
      @login['password'] = password
      @login['url']      = url
      @login['name']     = username
      @login['enabled']  = enabled
      break
    end
  end
end

Then /^I load @var from spreadsheet$/ do
  @var                   = Hash.new
  @workbook.default_sheet = @workbook.sheets[1]
  script_col             = 0
  name_col               = 0

  1.upto(@workbook.last_column) do |col|
    header = @workbook.cell(1, col)
    case header
      when @feature_name
        script_col = col
      when 'Variable'
        name_col = col
    end
  end

  2.upto(@workbook.last_row) do |line|
    name       = @workbook.cell(line, name_col)
    value      = @workbook.cell(line, script_col).to_s.strip
    @var[name] = value
  end
end

#Before do
#  manifest_file = File.join(File.dirname(__FILE__), '..', 'manifest.json')
#  @params = JSON.parse(File.open(manifest_file).read)['params'] #Have access to all params in manifest file
#end
