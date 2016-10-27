require 'rails_helper'

RSpec.describe EventsController, type: :controller do
    fixtures :users

    before(:each) do
        sign_in users(:tester)
        post :create_event, :title=>"Soccer", :location => "My House", :description => "It is going up!" :date=> Time.now
        @doc = Event.where(title: "Soccer").take
    end
    
    describe "create event" do
        it 'creates a events' do
            post :create_event, :title => "Boxing", :location => "Manhattan", :description => "It is going down!" :date=> Time.now
            flash[:notice].should eq("Event titled Boxing created successfully and email was successfully sent")
        end
    end
end
