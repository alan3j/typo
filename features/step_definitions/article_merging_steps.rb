#-- User accounts
non_admin = Hash.new; admin = Hash.new
non_admin[:username] = 'pub1'; non_admin[:password] = 'pub11'
admin[:username] = 'testadmin'; admin[:password] = 'testadminpw'

#-- Initialize users and articles for the test


Given /^I am logged in with (a|an) '(.*)' account$/ do |boo, admin_type|
  case admin_type.downcase
  when 'non-admin'
    login non_admin
  when 'admin'
    login admin
  end
end

def login(user)
  visit '/accounts/login'
#-- debugger
#--  puts page.html
    if page.current_path == '/setup'
      initialize_blog
    else
      fill_in "user_login", :with => user[:username]
      fill_in "input[user_password]", :with => user[:password]
      click_button "login"
    end
  puts user[:username]
  puts user[:password]
  puts cookies
end

def initialize_blog
  fill_in "setting_blog_name", :with => "admin"
  fill_in "setting_email", :with => "admin@local.loc"
  click_button "submit"
#-- debugger
  puts page.html
end


Given /^I edit article '(\d+)'$/ do |arg1|
  pending # express the regexp above with the code you wish you had
end

Then /^I will 'not see' 'Merge Articles'$/ do
  pending # express the regexp above with the code you wish you had
end

Then /^I will 'see' 'Merge Articles'$/ do
  pending # express the regexp above with the code you wish you had
end


