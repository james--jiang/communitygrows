require 'rails_helper'

describe AnnouncementController do 
    fixtures :users
    fixtures :announcements
    before(:each) do
        sign_in users(:tester)
        post :create_announcement, :title => "Rspec", :content => "Is for testing", :committee_type => :internal
        @a = Announcement.where(title: "Rspec").first
    end
    describe 'show the announcements' do
        it 'shows main announcements' do
            get :show_announcements, :categories => [:dashboard]
            response.should render_template(:show_announcements)
        end
        it 'shows subcommittee announcments' do
            get :show_announcements, :categories => [:external, :internal, :executive]
            response.should render_template(:show_announcements)
        end
    end
    describe 'new announcement' do
        it 'renders the new announcment template' do
            get :new_announcement, :committee_type => :internal
            response.should render_template(:new_announcement)
        end
        it 'creates a new announcement' do
            response.should redirect_to(subcommittee_index_path(:committee_type => :internal))
        end
    end
    describe 'create announcement' do
        it 'doesn\'t accept an empty title' do
            post :create_announcement, :committee_type => :internal, :title => ''
            expect(flash[:notice]).to eq("Title field cannot be left blank.")
            expect(response).to redirect_to(new_committee_announcement_path(:internal))
        end

        describe 'emails' do
            # before(:each) do
            #     Rails.env.stub(:production? => true)
            # end
            it 'internal' do
                byebug
                Rails.env.stub(:production? => true)
                expect(NotificationMailer).to receive(:new_document_email)
                post :create_announcement, :committee_type => :internal, :title => "a"
            end
            it 'external' do
                Rails.env.stub(:production? => true)
                expect(NotificationMailer).to receive(:new_document_email)
                post :create_announcement, :committee_type => :external, :title => "a"
            end
            it 'executive' do
                Rails.env.stub(:production? => true)
                expect(NotificationMailer).to receive(:new_document_email)
                post :create_announcement, :committee_type => :executive, :title => "a"
            end
        end
    end
    describe 'edit announcement' do
        it 'renders edit announcment page' do
            get :edit_announcement, :announcement_id => @a.id, :committee_type => @a.committee_type
            response.should render_template(:edit_announcement)
        end
        it 'updates incorrectly' do 
            put :update_announcement, :title => nil, :content => @a.content, :announcement_id => @a.id, :committee_type => @a.committee_type, :announcement => { :id => @a.id }
            response.should redirect_to(edit_committee_announcement_path(:committee_type => :internal, :announcement_id => @a.id))
        end
        it 'updates the announcement' do
            put :update_announcement, :title => @a.title, :content => @a.content, :announcement_id => @a.id, :committee_type => @a.committee_type, :announcement => { :id => @a.id }
            response.should redirect_to(subcommittee_index_path(:committee_type => :internal))
        end
    end
    describe 'delete announcement' do   
        it 'deletes an announcement' do
            delete :delete_announcement, :announcement_id => @a.id, :committee_type => @a.committee_type
            response.should redirect_to(subcommittee_index_path(:committee_type => :internal))
            
        end
    end
    describe 'update announcement' do
        describe 'emails' do
            before(:each) do
                Rails.env.stub(:production? => true)
            end
            it 'internal' do
                Rails.env.stub(:production? => true)
                expect(NotificationMailer).to receive(:new_document_email)
                put :update_announcement, :title => nil, :content => @a.content, :announcement_id => @a.id, :committee_type => @a.committee_type, :announcement => { :id => @a.id }
            end
            it 'external' do
                Rails.env.stub(:production? => true)
                @a.committee_type = :external
                expect(NotificationMailer).to receive(:new_document_email)
                put :update_announcement, :title => nil, :content => @a.content, :announcement_id => @a.id, :committee_type => @a.committee_type, :announcement => { :id => @a.id }
            end
            it 'executive' do
                Rails.env.stub(:production? => true)
                @a.committee_type = :executive
                expect(NotificationMailer).to receive(:new_document_email)
                put :update_announcement, :title => nil, :content => @a.content, :announcement_id => @a.id, :committee_type => @a.committee_type, :announcement => { :id => @a.id }
            end
        end
    end

    describe 'search' do
        it 'searches right' do 
            post :search_announcements, :search => @a.title
            response.should render_template(:show_announcements)
        end
    end
end