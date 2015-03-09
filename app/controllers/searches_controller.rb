class SearchesController < ApplicationController
  def search
    @query = params[:q].to_s

    #Since kaminari reduces the collection size to the argument
    #in per(), # of results has to be calculated before pagination
    @courses = Course.search(@query)
    @c_size = @courses.size
    @courses = @courses.page(params[:cpage]).per(5)

    @attachments = Attachment.search(@query).approved
    @a_size = @attachments.size
    @attachments = @attachments.page(params[:apage]).per(10)

    @users = User.search(@query)
    @u_size= @users.size
    @users = @users.page(params[:upage]).per(6)

    @guides = Guide.search(@query).approved
    @g_size= @guides.size
    @guides = @guides.page(params[:gpage]).per(5)

    @results = @c_size + @a_size + @u_size + @g_size


    respond_to do |format|
      format.js
      format.html
    end
  end
end
