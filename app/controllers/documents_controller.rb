class DocumentsController < ActionController::Base
    layout "base"
    before_filter :authenticate_user!
    
    def file_params
      params.require(:file).permit(:title, :url, :committee_type, :category)
    end
  
    def index
        # @documents = Document.all
        # @document_list = Document.order(updated_at: :DESC)
        @categories = Category.all
        @curr_user = current_user
    end
    
    def info_file
        @id = params[:format] 
        @file = Document.find @id
        @categories = Category.all
        @users = User.all.order(:email)
        @who_has_read = @file.users
    end
    
    def create_file
        begin
        file = params[:file]
            if file[:title].to_s == "" or file[:url].to_s == ""
                flash[:notice] = "Populate all fields before submission."
                redirect_to new_file_path
            elsif !(file[:url]=~/.com(.*)/)
                flash[:notice] = "Please enter a valid URL."
                redirect_to new_file_path
            else 
                if !(file[:url]=~/http(s)?:/)
                    file[:url]="http://"+file[:url]
                end
                category = Category.find(file[:category_id])
                @file = category.documents.create!(file_params)
                if Rails.env.production?
                    User.all.each do |user| 
                        NotificationMailer.new_document_email(user, Document.find_by_title(file[:title])).deliver
                    end
                end
                flash[:notice] = "#{@file.title} was successfully created and email was succesfully sent."
                redirect_to documents_path 
            end
        end
    end
    
    
    def edit_file
       @id = params[:format] 
       @file = Document.find @id
       @categories = Category.all
    end
    
    def update_file
        @target_file = Document.find params[:format]
        file = params[:file]
        if file[:title].to_s == "" or file[:url].to_s == ""
            flash[:notice] = "Populate all fields before submission."
            redirect_to edit_file_path(params[:format])
        elsif !(file[:url]=~/.com(.*)/)
            flash[:notice] = "Please enter a valid URL."
            redirect_to new_file_path
        else
            if !(file[:url]=~/http(s)?:/)
                file[:url]="http://"+file[:url]
            end
            category = Category.find(file[:category_id])
            @target_file.update_attributes!(file_params)
            category.documents << @target_file
            if Rails.env.production?
                User.all.each do |user| 
                    NotificationMailer.document_update_email(user, Document.find_by_title(file[:title])).deliver
                end
            end
            flash[:notice] = "Document with title [#{@target_file.title}] updated successfully and email was successfully sent."
            redirect_to(documents_path)
        end
    end
    
    def delete_file
        @file_to_delete = Document.find params[:format]
        @file_to_delete.destroy!
        flash[:notice] = "Document with title [#{@file_to_delete.title}] deleted successfully."
        redirect_to documents_path
    end
    
    def new_file
        #default: render 'new' template
        @categories = Category.all
    end
    
    def mark_as_read
        @id = params[:id]
        @file = Document.find @id
        @who_has_read = @file.users
        @curr_user = current_user
        if @curr_user.documents.exists?(@file)
            @curr_user.documents.delete(@file)
            flash[:notice] = "Document [#{@file.title}] marked as not read."
        else
            @curr_user.documents<<(@file)
            flash[:notice] = "Document [#{@file.title}] marked as read."
        end
        redirect_to :back
    end
    
    
end