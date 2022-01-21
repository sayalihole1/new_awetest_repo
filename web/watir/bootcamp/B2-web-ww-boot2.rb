#Bootcamp Example 1: Firefox, Watir-webdriver
require 'rubygems'
require 'watir-webdriver'
require 'pry'

timestamp = Time.now.strftime("%Y%m%d%H%M%S")

# open the browser
browser = Watir::Browser.new     # Watir-webdriver defaults to firefox
browser.goto("https://accounts.zoho.com/login?serviceurl=https://www.zoho.com/&hide_signup=true&css=https://www.zoho.com/css/login.css")
sleep(2)

# log in
browser.text_field(:name,'lid').set("joeklienwatir@gmail.com")
browser.text_field(:name,'pwd').set("watir001")
browser.button(:value,'Sign In').click
sleep(2)

# navigate to Accounts in CRM Software
browser.link(:title, 'CRM Software').click
sleep(2)
browser.link(:id, 'tab_Accounts').click
sleep(2)

# add new account
browser.button(:value, 'New Account').click
sleep(2)
browser.text_field(:name, /Account Name/).set("Acct #{timestamp}")
browser.button(:value, 'Save').click
sleep(2)

# verify saved account
browser.span(:id, 'value_Account Name').text == "Acct #{timestamp}"
sleep(2)
browser.link(:id, 'tab_Accounts').click
sleep(2)
puts browser.text.include?("Acct #{timestamp}")
sleep(2)

# delete the account
browser.link(:text, "Acct #{timestamp}").click
sleep(2)
browser.button(:name, 'Delete2').click
sleep(2)
browser.alert.ok    # Note Watir-webdriver difference
sleep(2)

# verify the account is gone
puts browser.text.include?("Acct #{timestamp}")
sleep(2)

# sign out and close browser
browser.image(:class,'sort_desc').click
browser.button(:value, 'Sign Out').click  # Won't work unless list dropped in Watir-webdriver
sleep(2)
browser.close
