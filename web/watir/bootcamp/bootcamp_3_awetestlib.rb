#Bootcamp Example 3 IE, Classic Watir, Awetestlib, with project library bootcamp_library.rb
$watir_script = true

module Bootcamp3CwAwetestlib

  def run_test(browser)
    acct_name = "Acct #{@timestamp}" # DRY: avoid literals

    navigate_to_accounts_in_crm(browser)
    open_new_account(browser, acct_name)
    edit_account(browser, acct_name)
    sleep_for(2)
    verify_account_saved(browser, acct_name)
    delete_account(browser, acct_name)
# verify the account is gone
    validate_no_text(browser, acct_name)
    sleep_for(2)

  end

  def edit_account(browser, acct_name)

    set_text_field(browser, :id, 'property(Phone)', @var['account_phone'])
    select_option(browser, :name, 'property(Account Type)', :text, @var['account_type'])
    select_option(browser, :name, 'property(Industry)', :text, @var['account_industry'])
    set_text_field(browser, :id, 'property(Billing Street)', @var['account_billing_street'])
    set_text_field(browser, :id, 'property(Billing City)', @var['account_billing_city'])
    set_text_field(browser, :id, 'property(Billing State)', @var['account_billing_state'])
    set_text_field(browser, :id, 'property(Billing Code)', @var['account_billing_zipcode'].to_i.to_s)
    set_text_field(browser, :id, 'property(Billing Country)', @var['account_billing_country'])

    click(browser, :button, :id, 'copyAddress')
    sleep_for(1)
    click(browser, :element, :text, 'Billing to Shipping')

    textfield_contains?(browser, :id, 'property(Shipping Street)', @var['account_billing_street'])
    textfield_contains?(browser, :id, 'property(Shipping City)', @var['account_billing_city'])
    textfield_contains?(browser, :id, 'property(Shipping State)', @var['account_billing_state'])
    textfield_contains?(browser, :id, 'property(Shipping Code)', @var['account_billing_zipcode'].to_i.to_s)
    textfield_contains?(browser, :id, 'property(Shipping Country)', @var['account_billing_country'])

    click(browser, :button, :value, 'Save')

  end

end
