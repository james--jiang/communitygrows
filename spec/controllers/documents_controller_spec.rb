require 'spec_helper'
require 'rails_helper'

describe DocumentsController do
    fixtures :users
    before(:each) do
        sign_in users(:tester)
        post :create_file, :file => {:title => "RepoTest", :url => "https://www.google.com/", :committee_type => 'boardoverview'}
        @doc = Document.find_by_title("RepoTest")
    end
    
    describe "create new document (file)" do
        it "renders the new document view" do
            get :new_file
            response.should render_template(:new_file)
        end
        
        it "can create a new document" do
            post :create_file, :file => {:title => "something", :url => "something.com", :committee_type => 'boardoverview'}
            expect(Document.find_by_title("something").title).to eql("something")
        end
        
        it 'checks for valid doc inputs' do
            post :create_file, :file => {:title => "something", :committee_type => :internal}
            flash[:notice].should eq("Populate all fields before submission.")
        
            post :create_file, :file => {:title => "something", :url => "something", :committee_type => 'boardoverview'}
            flash[:notice].should eq("Please enter a valid URL.")
        end
        
        it "development env sends email" do
            Rails.env.stub(:development? => true)
            post :create_file, :file => {:title => "something", :url => "something.com", :committee_type => 'boardoverview'}
        end
    end
    
    describe "acessing document page (index)" do
        it "accesses the index page successfully" do
            get :index
            response.should render_template(:index)
        end
    end
    
    describe "edit/update document (file) in the doc info page" do
        before(:each) do
            get :info_file, :format => @doc.id
        end
        
        it "edits a document" do
            put :update_file, {:format => @doc.id, :file => {:title => "ccc", :url => "ddddd.com", :committee_type => 'boardoverview'}}
            page.should redirect_to(:documents)
            expect(Document.find(@doc.id).title).to eql("ccc")
        end
        
        it "checks for populated fields" do
            put :update_file, {:format => @doc.id, :file => {:title => "ccc", :committee_type => 'boardoverview'}}
            flash[:notice].should eq("Populate all fields before submission.") 
        end
        
        it "checks validity of URL" do
            put :update_file, {:format => @doc.id, :file => {:title => "ccc", :url => "ddddd", :committee_type => 'boardoverview'}}
            flash[:notice].should eq("Please enter a valid URL.") 
        end
        
        it "development env sends email" do
            Rails.env.stub(:development? => true)
            put :update_file, {:format => @doc.id, :file => {:title => "ccc", :url => "ddddd.com", :committee_type => 'boardoverview'}}
        end
    end
    
    describe "delete document" do
        it "shows a flash delete message when document successfully deleted" do
            get :delete_file, {:format => @doc.id}
            flash[:notice].should eq("Document with title [#{@doc.title}] deleted successfully.")
        end
        
        it "should redirect to the documents repo page after deletion" do
            get :delete_file, {:format => @doc.id}
            response.should redirect_to(:documents)
        end
    end
    
    
    describe "Document info page" do
        before(:each) do
            get :info_file, :format => @doc.id
        end
        
        it 'should render the doc info page' do
            response.should render_template(:info_file)
        end
    end
end   

