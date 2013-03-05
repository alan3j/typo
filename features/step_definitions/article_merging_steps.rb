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

  #-- Ended up copying db_development to db_test - GodDammit!!!
  #-- user1 = FactoryGirl.create(:user, {:login => 'testadmin', :email => 'testadmin@local.loc', :name => 'testadmin', :password => 'testadmin', :profile_id => 1})
  #-- puts user1
  #-- blog1 = FactoryGirl.create(:blog)
  #-- puts blog1

  #-- if page.has_content?('My Shiny Weblog!')
  #--     fill_in("setting_blog_name", :with => "jtz Test")
  #--     fill_in("setting_email", :with => "testadmin@local.loc")
  #--     click_button("submit")
  #--   end

  #-- puts user[:username]
  #-- puts user[:password]
  #-- puts cookies
end

Given /^I edit article '(\d+)'$/ do |article_id|
  visit "/admin/content/edit/#{article_id}"
  assert(page.has_content?("Hey; I mean, Hi."), "Expected to see an editor")
end

Then /^I will '(.*)' 'Merge Articles'$/ do |vision|
  case vision.downcase
  when 'not see'
    assert(page.has_no_content?("Merge Articles"), "Expected not to see content 'Merge Articles'")
  when 'see'
    assert(page.has_content?("Merge Articles"), "Expected to see content 'Merge Articles'")
  end
end

Then /^I will log out$/ do
  visit "/accounts/logout"
end


