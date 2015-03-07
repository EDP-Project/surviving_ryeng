class SearchesController < ApplicationController
  def search
    @query = params[:q].to_s
    @courses = Course.search(@query)
    @attachments = Attachment.search(@query)
    @users = User.search(@query)
    @guides = Guide.search(@query)
    @results = @courses.size + @attachments.size + @users.size + @guides.size

  end
end
