require "rails_helper"
require "spec_helper"
require 'rspec/active_model/mocks'

RSpec.describe NotificationMailer, type: :mailer do
  describe 'new event' do
    let(:user) { mock_model User, name: 'James', email: 'james@email.com' }
    let(:event) { mock_model Event, title: 'Boxing', location: 'Berkeley', date: Time.now, description: 'Fun event' }

    let(:mail) { NotificationMailer.new_event_email(user,event)}

    it 'renders the subject' do
      expect(mail.subject).to eql('New Event Created')
    end

    it 'renders the receiver email' do
      expect(mail.to).to eql([user.email])
    end

    it 'renders the sender email' do
      expect(mail.from).to eql(['communitygrows2@gmail.com'])
    end

    it 'contains title' do
      expect(mail.body.encoded).to include(event.title)
    end

    it 'contains location' do
      expect(mail.body.encoded).to include(event.location)
    end
  end
  describe 'update event' do
    let(:user) { mock_model User, name: 'James', email: 'james@email.com' }
    let(:event) { mock_model Event, title: 'Boxing', location: 'Berkeley', date: Time.now, description: 'Fun event' }

    let(:mail) { NotificationMailer.event_update_email(user,event)}

    it 'renders the subject' do
      expect(mail.subject).to eql('Event Edited')
    end

    it 'renders the receiver email' do
      expect(mail.to).to eql([user.email])
    end

    it 'renders the sender email' do
      expect(mail.from).to eql(['communitygrows2@gmail.com'])
    end

    it 'contains title' do
      expect(mail.body.encoded).to include(event.title)
    end

    it 'contains location' do
      expect(mail.body.encoded).to include(event.location)
    end
  end
  describe 'new announcement' do
    let(:user) { mock_model User, name: 'James', email: 'james@email.com' }
    let(:announcement) { mock_model Announcement, title: 'Raining', content: 'It is raining' }

    let(:mail) { NotificationMailer.announcement_email(user,announcement)}

    it 'renders the subject' do
      expect(mail.subject).to include('New Announcement Created:')
    end

    it 'renders the receiver email' do
      expect(mail.to).to eql([user.email])
    end

    it 'renders the sender email' do
      expect(mail.from).to eql(['communitygrows2@gmail.com'])
    end


    it 'contains content' do
      expect(mail.body.encoded).to include(announcement.content)
    end
  end

  describe 'update announcement' do
    let(:user) { mock_model User, name: 'James', email: 'james@email.com' }
    let(:announcement) { mock_model Announcement, title: 'Raining', content: 'It is raining' }

    let(:mail) { NotificationMailer.announcement_update_email(user,announcement)}

    it 'renders the subject' do
      expect(mail.subject).to include('Announcement Updated:')
    end

    it 'renders the receiver email' do
      expect(mail.to).to eql([user.email])
    end

    it 'renders the sender email' do
      expect(mail.from).to eql(['communitygrows2@gmail.com'])
    end


    it 'contains content' do
      expect(mail.body.encoded).to include(announcement.content)
    end
  end

  describe 'create document' do
    let(:user) { mock_model User, name: 'James', email: 'james@email.com' }
    let(:document) { mock_model Document, document: 'Important Read', content: 'www.communitygrows.com/document/example.pdf' }

    let(:mail) { NotificationMailer.new_document_email(user,document)}

    it 'renders the subject' do
      expect(mail.subject).to eql('New Document Created')
    end

    it 'renders the receiver email' do
      expect(mail.to).to eql([user.email])
    end

    it 'renders the sender email' do
      expect(mail.from).to eql(['communitygrows2@gmail.com'])
    end


    it 'contains content' do
      expect(mail.body.encoded).to include("document")
    end
  end

  describe 'update document' do
    let(:user) { mock_model User, name: 'James', email: 'james@email.com' }
    let(:document) { mock_model Document, document: 'Important Read', content: 'www.communitygrows.com/document/example.pdf' }

    let(:mail) { NotificationMailer.document_update_email(user,document)}

    it 'renders the subject' do
      expect(mail.subject).to eql('Document Edited')
    end

    it 'renders the receiver email' do
      expect(mail.to).to eql([user.email])
    end

    it 'renders the sender email' do
      expect(mail.from).to eql(['communitygrows2@gmail.com'])
    end


    it 'contains content' do
      expect(mail.body.encoded).to include("document")
    end
  end


end
