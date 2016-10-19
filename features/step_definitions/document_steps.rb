Given /^I check out four categories of document repository$/ do
  fail "Unimplemented"
end

Given /the following documents exist/ do |documents_table|
    Document.delete_all
    documents_table.hashes.each do |document|
        Document.create!(document)
    end
end