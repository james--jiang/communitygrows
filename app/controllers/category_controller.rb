class CategoryController < ActionController::Base
    layout "base"
    before_filter :authenticate_user!

    def index
        @categories = Category.all
    end

    def new_category
        if !current_user.admin
            flash[:message] = "Access not granted. Please sign in again."
            redirect_to("/users/sign_in")
        end
    end
    
    def create_category
        if !current_user.admin
            flash[:message] = "Access not granted. Please sign in again."
            redirect_to("/users/sign_in")
        else
            category = params[:category]
            if category[:name].to_s == "" then
                flash[:notice] = "Please fill in the category name field."
                redirect_to new_category_path
            elsif Category.has_name?(category[:name]) then
                flash[:notice] = "The category name provided already exists. Please enter a different name."
                redirect_to new_category_path
            else
                Category.create!(:name => category[:name])
                flash[:notice] = "The category #{category[:name]} was successfully created!"
                redirect_to category_index_path
            end
        end
    end

    def edit_category
        if !current_user.admin
            flash[:message] = "Access not granted. Please sign in again."
            redirect_to("/users/sign_in")
        end
        @id = params[:id] 
        @category = Category.find(@id)
        @categories = Category.all
    end

    def update_category
        if !current_user.admin
            flash[:message] = "Access not granted. Please sign in again."
            redirect_to("/users/sign_in")
        else
            @category = Category.find(params[:id])
            category = params[:category]
            if category[:name].to_s == '' then
                flash[:notice] = "Please fill in the category name field."
                redirect_to edit_category_path
            elsif Category.has_name?(category[:name].to_s)
                flash[:notice] = "The category name provided already exists. Please enter a different name."
                redirect_to edit_category_path
            else
                @category.update_attributes!(:name => category[:name].to_s)
                flash[:notice] = "Categroy with name [#{@category.name}] updated successfully and email was successfully sent."
                redirect_to category_index_path
            end
        end
            
    end

    def delete_category
        if !current_user.admin
            flash[:message] = "Access not granted. Please sign in again."
            redirect_to("/users/sign_in")
        else
            @category = Category.find(params[:id])
            @category.destroy!
            flash[:notice] = "Category with name #{@category.name} deleted successfully."
            redirect_to category_index_path
        end
    end

    def hide_category
        if !current_user.admin
            flash[:message] = "Access not granted. Please sign in again."
            redirect_to("/users/sign_in")
        else
            category = Category.find(params[:id])
            category.hide
            flash[:notice] = "#{category.name} successfully hidden."
            redirect_to category_index_path
        end
    end

    def show_category
        if !current_user.admin
            flash[:message] = "Access not granted. Please sign in again."
            redirect_to("/users/sign_in")
        else
            category = Category.find(params[:id])
            category.show
            flash[:notice] = "#{category.name} successfully shown."
            redirect_to category_index_path
        end
    end

end

