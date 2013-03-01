Given /the following articles exist/ do |articles_table|
  articles_table.hashes.each do |article|
    Article.create!(article)
  end
end

Given /the following users exist/ do |users_table|
  users_table.hashes.each do |user|
    User.create!(user)
  end
end

Given /the following comments exist/ do |comments_table|
  comments_table.hashes.each do |comment|
    Comment.create!(comment)
  end
end

Given /^I am logged into the admin panel as "(.*)"$/ do |user|
  visit "/accounts/login"
  fill_in "user_login", :with => user
  fill_in "user_password", :with => user
  click_button "Login"
end

When /^I merge the article with "(.*)"$/ do |article|
  fill_in "merge_with", :with => Article.find_by_title(article).id
  click_button "Merge"
end
