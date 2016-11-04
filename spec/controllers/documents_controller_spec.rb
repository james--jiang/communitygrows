require 'spec_helper'
require 'rails_helper'

describe DocumentsController do
    fixtures :users
    before(:each) do
        sign_in users(:tester)
        Category.create!({:id => 1, :name => "Good Category"})
        post :create_file, :file => {:title => "RepoTest", :url => "https://www.google.com/", :committee_type => 'boardoverview', :category_id => 1}
        @doc = Document.find_by_title("RepoTest")
    end
    
    describe "create new document (file)" do
        it "renders the new document view" do
            get :new_file
            expect(response).to render_template(:new_file)
        end
        
        it "can create a new document" do
            post :create_file, :file => {:title => "something", :url => "something.com", :committee_type => 'boardoverview', :category_id => 1}
            expect(Document.find_by_title("something").title).to eql("something")
        end
        
        it 'checks for valid doc inputs' do
            post :create_file, params: {file: {title: "something", committee_type: :internal}}
            expect(flash[:notice]).to eq("Populate all fields before submission.")
        
            post :create_file, :file => {:title => "something", :url => "something", :committee_type => 'boardoverview', :category_id => 1}
            flash[:notice].should eq("Please enter a valid URL.")
        end
        
        it "production env sends email" do
            Rails.env.stub(:production? => true)
            post :create_file, :file => {:title => "something", :url => "something.com", :committee_type => 'boardoverview', :category_id => 1}
        end
    end
    
    describe "accessing document page (index)" do
        it "accesses the index page successfully" do
            get :index
            expect(response).to render_template(:index)
        end
    end
    
    describe "edit/update document (file) in the doc info page" do
        before(:each) do
            get :info_file, format: @doc.id
        end
        
        it "edits a document" do
            put :edit_file, {:format => @doc.id}
            put :update_file, {:format => @doc.id, :file => {:title => "ccc", :url => "ddddd.com", :committee_type => 'boardoverview', :category_id => 1}}
            page.should redirect_to(:documents)
            expect(Document.find(@doc.id).title).to eql("ccc")
        end
        
        it "checks for populated fields" do
            put :update_file, {:format => @doc.id, :file => {:title => "ccc", :committee_type => 'boardoverview', :category_id => 1}}
            flash[:notice].should eq("Populate all fields before submission.") 
        end
        
        it "checks validity of URL" do
            put :update_file, {:format => @doc.id, :file => {:title => "ccc", :url => "ddddd", :committee_type => 'boardoverview', :category_id => 1}}
            flash[:notice].should eq("Please enter a valid URL.") 
        end
        
        it "production env sends email" do
            Rails.env.stub(:production? => true)
            put :update_file, {:format => @doc.id, :file => {:title => "ccc", :url => "ddddd.com", :committee_type => 'boardoverview', :category_id => 1}}
        end
    end
    
    describe "delete document" do
        it "shows a flash delete message when document successfully deleted" do
            get :delete_file, params: {format: @doc.id}
            expect(flash[:notice]).to eq("Document with title [#{@doc.title}] deleted successfully.")
        end
        
        it "should redirect to the documents repo page after deletion" do
            get :delete_file, params: {format: @doc.id}
            expect(response).to redirect_to(:documents)
        end
    end
    
    
    describe "Document info page" do
        before(:each) do
            get :info_file, format: @doc.id
        end
        
        it 'should render the doc info page' do
            expect(response).to render_template(:info_file)
        end
    end
    
    describe "Mark as Read" do
        before(:each) do
            get :info_file, :format => @doc.id
        end
        
        it 'redirect to the info_file page after marked as read changed' do
            @request.env['HTTP_REFERER'] = info_file_path
            post :mark_as_read, :id => @doc.id
            expect(response).to redirect_to(info_file_path)
        end
        
        it 'displays marked as read flash message if initially not read' do
            @request.env['HTTP_REFERER'] = info_file_path
            post :mark_as_read, :id => @doc.id
            flash[:notice].should eq("Document [#{@doc.title}] marked as read.")
        end
        
        it 'displays marked as not read flash message if initially read' do
            @request.env['HTTP_REFERER'] = info_file_path
            post :mark_as_read, :id => @doc.id
            # Same controller method twice to mark as not read.
            post :mark_as_read, :id => @doc.id
            flash[:notice].should eq("Document [#{@doc.title}] marked as not read.")
        end
    end
end   

