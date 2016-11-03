Given /the following documents exist/ do |documents_table|
    Document.delete_all
    documents_table.hashes.each do |document|
        Document.create!(document)
    end
end

Given /^PENDING/ do
    pending
end

Then /^(?:|I )should see "([^"]*)" in Read Status Table$/ do |status|
    page.find("#mark_as_read_table").find('tr', text: "dummy@dummy.com").should have_content(status)
end

Given /a category called "([^"]*)"$/ do |category_name|
	Category.create!({:name => category_name, :hidden => false})
end

