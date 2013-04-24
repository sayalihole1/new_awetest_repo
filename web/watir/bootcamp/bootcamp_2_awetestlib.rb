#Bootcamp Example 2 IE, Classic Watir, Awetestlib, Excel data repository
module Bootcamp2CwAwetestlib

  $watir_script=true

  def run
    ts = Time.now.strftime("%Y%m%d%H%M%S")
    @acct_name = "Acct #{ts}"
    @xls_path = 'bootcamp_data.xls' unless @xls_path
    debug_to_report(@xls_path)
    get_variables("#{@myRoot}/#{@xls_path}", :role)  #allows run locally and in worker
    set_login

    browser = open_browser
    go_to_url(browser,@url)
    sleep_for(2)
    login(browser)
    add_account(browser)
    verify_account(browser)
    delete_verify_account(browser)
    logout_close(browser)
  end

  def set_login
    @login.each_key do |key|
      if @login[key]['enabled'] == 'Y'
        @user = @login[key]['userid']
        @pass = @login[key]['password']
        @role = @login[key]['role']
        @url  = @login[key]['url']
        debug_to_report("@user: #{@user}, @pass: #{@pass}, @role: #{@role}")
        break
      end
    end
  end

  def login(browser)
    set_textfield_by_name(browser, 'lid', @user)
    set_textfield_by_name(browser, 'pwd', @pass)
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
    close_modal_ie(browser, title="Message from webpage", button="OK", text='Are you sure ?')
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

