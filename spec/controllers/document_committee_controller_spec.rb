require 'spec_helper'
require 'rails_helper'

describe DocumentCommitteeController do 
    fixtures :users
    before(:each) do
        sign_in users(:tester)
        post :create_document, :title => "before hook", :url => "rspec.com", :committee_type => :internal
        @doc = Document.where(title: "before hook").take
    end
    
    describe "create document" do
        it "has a flash method for unpopulated fields" do
            post :create_document, :title => "Rspec", :committee_type => :internal
            flash[:notice].should eq("Populate all fields before submission.") 
        end
        
        
        it "checks validity of URL" do
            post :create_document, :title => "Rspec", :url => "rspec", :committee_type => :internal
            flash[:notice].should eq("Please enter a valid URL.") 
        end
        
        it 'creates a document' do
            post :create_document, :title => "Rspec", :url => "rspec.com", :committee_type => :internal
            flash[:notice].should eq("Document List creation successful and email was successfully sent.")
        end
        
        it "production env sends email" do
            Rails.env.stub(:production? => true)
            post :create_document, :title => "Rspec", :url => "rspec.com", :committee_type => :internal
        end
    end
    
    describe "edit document" do
        it 'renders edit page' do
            get :edit_document, :committee_type => @doc.committee_type, :id => @doc.id
            response.should render_template(:edit_document)
        end
    end
    
    describe "update document" do
        it "checks for populated fields" do
            put :update_document, :document => {:id => @doc.id}, :url => "new_url.com", :committee_type => @doc.committee_type
            flash[:notice].should eq("Populate all fields before submission.") 
        end
        
        it "checks validity of URL" do
            put :update_document, :document => {:id => @doc.id}, :title => @doc.title, :url => "new_url", :committee_type => @doc.committee_type
            flash[:notice].should eq("Please enter a valid URL.") 
        end
        
        it 'updates the document' do
            put :update_document, :document => {:id => @doc.id}, :title => @doc.title, :url => "new_url.com", :committee_type => @doc.committee_type 
            response.should redirect_to(subcommittee_index_path(:committee_type => @doc.committee_type))
        end
        
        it "production env sends email" do
            Rails.env.stub(:production? => true)
            put :update_document, :document => {:id => @doc.id}, :title => @doc.title, :url => "new_url.com", :committee_type => @doc.committee_type 
        end
    end
    
    describe 'deleting document' do
        it 'deletes' do
            delete :delete_document, :committee_type => @doc.committee_type, :document_id => @doc.id
            response.should redirect_to(subcommittee_index_path(:committee_type => @doc.committee_type))
        end
    end

    
end