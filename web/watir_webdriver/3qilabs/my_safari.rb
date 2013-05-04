require 'rubygems'
require 'watir-webdriver'

b=Watir::Browser.new (:remote, :desired_capabilities=>:'safari')
b.goto("www.google.com")
b.text_field(:name, "q").set("3qilabs")
sleep 5
b.button(:name, "btnG").click
#b.link(:text,"3 QI Labs | Automated Testing with Watir, Selenium, and Sikuli").exist?
b.text.include? "3QI Labs"
b.close
