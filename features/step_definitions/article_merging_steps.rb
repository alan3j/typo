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
#-- debugger
  u = FactoryGirl.create(:user)
  puts u
  visit '/accounts/login'
#-- debugger
  puts page.html
  puts user[:username]
  puts user[:password]
  puts cookies
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


