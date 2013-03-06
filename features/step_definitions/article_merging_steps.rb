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
  #-- Burn articles 3 and 4
  (1..2).each {FactoryGirl.create(:article, {:title => 'An article', :body => 'A body'})}
  #-- Article 5
  FactoryGirl.create(:article,
    {:author => 'testadmin',
     :user_id => 3,
     :title => 'Admin says hi',
     :body => '<h1>Hi everybody <em>!!!</em></h1><p>&nbsp;</p>'})
  #-- Burn article 6
  FactoryGirl.create(:article, {:title => 'An article', :body => 'A body'})
  #-- Article 7
  FactoryGirl.create(:article,
    {:author => 'pub1',
     :user_id => 2,
     :title => 'Hi from publisher 1',
     :body => 'Hey; I mean, Hi.</p>'})

  #-- Add comments
  article_5 = Article.find(5); article_7 = Article.find(7)
  FactoryGirl.create(:comment, {:article => article_5, :body => "Comment 1 on '#{article_5.title}'"})
  FactoryGirl.create(:comment, {:article => article_5, :body => "Comment 2 on '#{article_5.title}'"})
  FactoryGirl.create(:comment, {:article => article_7, :body => "Comment 1 on '#{article_7.title}'"})
  FactoryGirl.create(:comment, {:article => article_7, :body => "Comment 2 on '#{article_7.title}'"})

  assert( ((article_5.comments.count == 2) and (article_7.comments.count == 2)), 
    'Test article creating failed' )
end

Then /^Article '(\d+)' will have author '(.*)'$/ do |article_id, author|
  assert(Article.find(article_id).author == author,
    "Expected author, #{author}, not found")
end

Then /^Article '(\d+)' will have '(\d+)' comments$/ do |article_id, number_of_comments|
  assert(Article.find(article_id).comments.count == number_of_comments.to_i,
    "Expected number of comments, #{number_of_comments}, not found")
end

Then /^Article '(\d+)' will have title '(.*)'$/ do |article_id, title|
  assert(Article.find(article_id).title == title,
    "Expected title, #{title}, not found")
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




