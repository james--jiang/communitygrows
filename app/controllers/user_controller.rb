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
        # rewrite this method
        # the model is already update through form_for 
        # so the question is what do we do here
        @user = User.find(params[:user_id])
        # if @user.internal == 1
        #     @user.internal = true
        # end
        # if @user.external == 1
        #     @user.external = true
        # end
        # if @user.executive == 1
        #     @user.executive = true
        # end
        
        if @user.update_attributes(user_params)
            print "start here"
            print @user.internal
            if @user.internal == 1
                @user.internal = true
                @user.save!
            end
            print @user.internal
            if @user.external == 1
                @user.external = true
                @user.save!
            end
            if @user.executive == 1
                @user.executive = true
                @user.save!
            end
            if display_error(@user)
                print "Huh"
                flash[:notice] = "Please select at least your committee to receive emails from."
            else
                flash[:notice] = "Email Preferences were updated."
            end
        else
            flash[:notice] = flash[:notice].to_a.concat @user.errors.full_messages
        end
        redirect_to user_credentials_path(@user.id)    

    end
    
    def display_error(user)
        print "ever"
        if user.internal.nil? and user.external.nil? and user.executive.nil?
            return true
        elsif user.internal == 0 and user.external == 0 and user.executive == 0
            return true
        elsif user.internal.nil? and user.external == 0 and user.executive == 0
            return true
        elsif user.internal == 0 and user.external.nil? and user.executive == 0
            return true
        elsif user.internal == 0 and user.external == 0 and user.executive.nil?
            return true
        elsif user.internal == 0 and user.external.nil? and user.executive.nil?
            return true
        elsif user.internal.nil? and user.external == 0 and user.executive.nil?
            return true
        elsif user.internal.nil? and user.external.nil? and user.executive == 0
            return true
        end
    end

end