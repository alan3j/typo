#-- User accounts
non_admin = Hash.new; admin = Hash.new
non_admin[:username] = 'pub1'; non_admin[:password] = 'pub11'
admin[:username] = 'testadmin'; admin[:password] = 'testadminpw'

#-- db_test copied from db_development for initialization


Given /^I have added my test user accounts$/ do

  #-- Non-admin
  visit '/admin/users/new'
  fill_in 'user_login', :with => non_admin[:username]
  fill_in 'user_password', :with => non_admin[:password]
  fill_in 'user_password_confirmation', :with => non_admin[:password]
  fill_in 'user_email', :with => "#{non_admin[:username]}@local.loc"
  select 'Blog publisher', :from => 'user_profile_id'
  fill_in 'user_firstname', :with => non_admin[:username]
  fill_in 'user_lastname', :with => non_admin[:username]
  fill_in 'user_nickname', :with => non_admin[:username]
  click_button 'Save'
  if page.respond_to? :should
    page.should have_content('User was successfully created.')
  else
    assert page.has_content?('User was successfully created.')
  end

  #-- Admin
  visit '/admin/users/new'
  fill_in 'user_login', :with => admin[:username]
  fill_in 'user_password', :with => admin[:password]
  fill_in 'user_password_confirmation', :with => admin[:password]
  fill_in 'user_email', :with => "#{admin[:username]}@local.loc"
  select 'Typo administrator', :from => 'user_profile_id'
  fill_in 'user_firstname', :with => admin[:username]
  fill_in 'user_lastname', :with => admin[:username]
  fill_in 'user_nickname', :with => admin[:username]
  click_button 'Save'
  if page.respond_to? :should
    page.should have_content('User was successfully created.')
  else
    assert page.has_content?('User was successfully created.')
  end

end

Given /^I have added my test articles$/ do
  pending # express the regexp above with the code you wish you had
end





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

  fill_in("user_login", :with => user[:username])
  fill_in("user_password", :with => user[:password])
  click_button("Login")
  #--  puts '!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!'
  #--  puts page.html
  #--  puts '!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!'

  assert(page.has_content?("Welcome back, #{user[:username]}!"), "Expected \"#{user[:username]}\" to be logged in now")
end

Given /^I edit article '(\d+)'$/ do |article_id|
  visit "/admin/content/edit/#{article_id}"
  assert( ( page.has_content?("New article") and 
            page.has_content?("Tags") and
            page.has_content?("Excerpt") ), "Expected to see an editor")
end

Then /^I will '(.*)' '(.*)'$/ do |vision_type, envisioned|
  case vision_type.downcase
  when 'not see'
    assert(page.has_no_content?(envisioned), "Expected not to see content '#{envisioned}'")
  when 'see'
    assert(page.has_content?(envisioned), "Expected to see content '#{envisioned}'")
  end
end

Then /^I will log out$/ do
  visit "/accounts/logout"
end

Then /^I merge article '(\d+)' to article '(\d+)'$/ do |article_from, article_to|
  visit "/admin/content/merge/#{article_to}?merge_with=#{article_from}"
end




