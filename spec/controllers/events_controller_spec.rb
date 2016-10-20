require 'rails_helper'

RSpec.describe EventsController, type: :controller do
    fixtures :users

    before(:each) do
        sign_in users(:tester)
        post :create, :event=>{:title=>"Soccer", :location => "My House", :description => "It is going up!", :date=> Time.now, :url=>"www.google.com"}
    end
    
    describe "create event" do
        it 'creates a events' do
            post :create, :event=>{:title => "Boxing", :location => "Manhattan", :description => "It is going down!", :date=> Time.now,:url=>"www.google.com"}
            flash[:notice].should eq("Event titled Boxing created successfully and email was successfully sent.")
        end
    end

    describe 'edit event' do
        it 'edits the event' do
            get :edit,:id => Event.find_by_title("Soccer").id
            response.should render_template(:edit)
        end 
    end

    describe 'update event' do
    	it 'updates the event' do
    		post :update, :id => Event.find_by_title("Soccer").id, :event=>{:title=>"Basketball", :location => "My House", :description => "It is going up!", :date=> Time.now, :url=>"www.google.com"}
            flash[:notice].should eq("Event was updated and email was successfully sent.")
        end
    end

    describe 'delete event' do
    	it 'deletes the event' do
    		temp_id = Event.find_by_title("Soccer").id
    		post :delete, :id => Event.find_by_title("Soccer").id
    		expect(Event.find_by_id(temp_id)).to be(nil)
    	end
    end
end

