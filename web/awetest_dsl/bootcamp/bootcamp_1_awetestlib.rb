#Bootcamp Example 2: IE, Classic Watir, Awetestlib
module Bootcamp1Awetestlib

  $watir_script=true

def run
	ts = Time.now.strftime("%Y%m%d%H%M%S")
	@acct_name = "Acct #{ts}"
	browser = open_browser
	go_to_url(browser,"https://accounts.zoho.com/login?serviceurl=https://www.zoho.com/&hide_signup=true&css=https://www.zoho.com/css/login.css")
	sleep_for(2)
	login(browser)
	add_account(browser)
	verify_account(browser)
	delete_verify_account(browser)
	logout_close(browser)
end

def login(browser)
	set_textfield_by_name(browser, 'lid', "joeklienwatir@gmail.com")
	set_textfield_by_name(browser, 'pwd', "watir001")
	click_button_by_value(browser, "Sign In")
	sleep_for(2)
end

def add_account(browser)
	click(browser, :link, :title, "CRM Software")
	sleep_for(2)
	click(browser, :link, :id, "tab_Accounts")
	sleep_for(2)
	click_button_by_value(browser, "New Account")
	sleep_for(2)
	set_textfield_by_name(browser, /Account Name/, @acct_name)
	click_button_by_value(browser, "Save")
	sleep_for(2)
end

def verify_account(browser)
	element_contains_text?(browser, :span, :id, 'value_Account Name', @acct_name) 
	#validate_text(browser, @acct_name)
	click(browser, :link, :id, "tab_Accounts")
	puts validate_text(browser, @acct_name)
	sleep_for(2)
	#validate_textfield_value_by_id(browser, 'value_Account Name', @acct_name)
end

def delete_verify_account(browser)
	click(browser, :link, :text, @acct_name)
	sleep_for(2)
	click_button_by_name(browser, "Delete2")
	sleep_for(2)
	close_modal(browser, title="Message from webpage", button="OK", text='Are you sure ?')
	sleep_for(2)
	validate_no_text(browser, @acct_name)
	#puts validate_text(browser, @acct_name)	
	sleep_for(2)
end

def logout_close(browser)
	click(browser, :image, :class, 'sort_desc')
	click_button_by_value(browser, "Sign Out")
	sleep_for(2)
	browser.close
end

end
