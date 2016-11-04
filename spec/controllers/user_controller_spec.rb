require 'rails_helper'
require 'spec_helper'

describe UserController do
    fixtures :users
    before(:each) do
        sign_in users(:tester)
    end
    describe 'index' do
        it 'renders index page' do
            get :index, params: {user_id: users(:tester).id}
            expect(response).to render_template(:index)
        end
    end
    describe 'update' do
        it 'should redirect to account info page on success' do
            user_params = {email: "tester@rspec.com", password: "communitygrowsrocks", password_confirmation: "communitygrowsrocks"}
            put :update, params: {user_id: users(:tester).id, user: user_params}
            expect(response).to redirect_to(update_user_credentials_path(users(:tester).id))
        end
        it 'should redirect to redirect to account info page on failure with failure message' do
            user_params = {email: "tester@rspec.com", password: "", password_confirmation: ""}
            put :update, params: {user_id: users(:tester).id, user: user_params}
            expect(response).to redirect_to(update_user_credentials_path(users(:tester).id))
        end
    end
end