Given /the following categories exist/ do |categories_table|
  categories_table.hashes.each do |category|
    Category.create!(category)
  end
end

When /^I delete the category "(.*)"$/ do |category|
  visit "/admin/categories/destroy/#{Category.find_by_name(category).id}"
  click_button("delete")
end
