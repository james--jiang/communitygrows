require 'rails_helper'

RSpec.describe User, type: :model do
    describe "new user" do
  	    it "create new user" do
  	    	u = User.new
  	    	u.email = "jack@gmail.com"
  	    	u.delete
  	    end
    end

end
