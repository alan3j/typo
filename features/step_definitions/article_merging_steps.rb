#-- User accounts
non_admin = Hash.new; admin = Hash.new
non_admin[:username] = 'pub1'; non_admin[:password] = 'pub11'
admin[:username] = 'testadmin'; admin[:password] = 'testadminpw'

#-- db_test copied from db_development for initialization


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




