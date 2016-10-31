class UserController < ActionController::Base
    layout "base"
    before_filter :authenticate_user!
    
    def user_params
        params.require(:user).permit(:email, :password, :password_confirmation, :internal, :external, :executive)
    end
    
    def index
        @user = User.find params[:user_id]
        if flash[:notice] == "Signed in successfully."
            flash[:notice] = nil
        end
    end
    
    def update

        @user = User.find(params[:user_id])
        if @user.update_attributes(user_params)
            bypass_sign_in(@user)
            flash[:notice] = "#{@user.email}'s credentials were successfully updated."
            redirect_to user_credentials_path(@user.id)
        else
            flash[:notice] = flash[:notice].to_a.concat @user.errors.full_messages
            redirect_to user_credentials_path(@user.id)    
        end
    end

    def updateEmailPreferences
        @user = User.find(params[:user_id])
        if @user.update_attributes(user_params)
            flash[:notice] = "feifejiejwzibirvsd"
        else
            flash[:notice] = flash[:notice].to_a.concat @user.errors.full_messages
        end
        redirect_to user_credentials_path(@user.id)    

    end

end