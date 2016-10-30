Given /^I check out four categories of document repository$/ do
  fail "Unimplemented"
end

Given /the following documents exist/ do |documents_table|
    Document.delete_all
    documents_table.hashes.each do |document|
        Document.create!(document)
    end
end

Given /a category called "([^"]*)"$/ do |category_name|
	Category.create!({:name => category_name, :hidden => false})
end