module MainPagesHelper

  def af_icon_for (resource)
    type = resource.reportable_type || resource.attachable_type 
    case type
    when "Course"
      return content_tag(:i, nil, class: 'fa fa-book')
    when "Attachment"
      return content_tag(:i, nil, class: 'fa fa-paperclip')
    when "Guide"
      return content_tag(:i, nil, class: 'fa fa-newspaper-o')
    end
  end

  def reportable_link (report)
    case report.reportable_type 
    when "Guide"
      guide = Guide.find(report.reportable_id)
      return  link_to guide, class: 'btn btn-info' do
                content_tag(:i, nil, class: 'fa fa-rocket') + " View Guide"
              end
    when "Attachment"
      attachment = Attachment.find(report.reportable_id)
      return  link_to attachment, class: 'btn btn-info' do
                content_tag(:i, nil, class: 'fa fa-rocket') + " View Attachment"
              end
    when "User"
      user = User.find(report.reportable_id)
      return  link_to user_path(username: user.username), class: 'btn btn-info' do
                content_tag(:i, nil, class: 'fa fa-rocket') + " View Attachment"
              end
    
    else
      return  link_to admin_feed_path, class: 'btn btn-info' do
        content_tag(:i, nil, class: 'fa fa-rocket') + "Return to Admin Feed"
      end
    end

  end

end
