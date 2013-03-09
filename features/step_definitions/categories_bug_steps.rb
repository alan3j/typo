Given /^I edit category '(\d+)'$/ do |category_id|
  visit "/admin/categories/edit/#{category_id}"
  fill_in 'category_name', :with => 'Major'
  fill_in 'category_permalink', :with => 'major'
  click_button 'Save'
end

Given /^I add category 'Random'$/ do
  visit '/admin/categories/new'
  fill_in 'category_name', :with => 'Random'
  fill_in 'category_permalink', :with => 'random'
  fill_in 'category_description', :with => 'garbage'
  click_button 'Save'
end


