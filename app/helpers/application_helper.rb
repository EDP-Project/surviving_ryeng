module ApplicationHelper
  
  def full_title(specific_page)
    if specific_page.empty?
      'Surviving RyEng'
    else
      "Surviving RyEng | #{specific_page}"
    end
  end

  def bootstrap_class_for(flash_type)
    case flash_type
      when "success"
        "alert-success"   # Green
      when "error"
        "alert-danger"    # Red
      when "alert"
        "alert-warning"   # Yellow
      when "notice"
        "alert-info"      # Blue
      else
        flash_type.to_s
    end
  end

  def gravatar_for(user, options = { size: 50 })
    gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
    size = options[:size]
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}&r=x&default=identicon"
    image_tag(gravatar_url, alt: user.last_name, class: "gravatar")
  end

  def permitted_to_modify?(resource)
    resource.user == current_user || current_user.admin? 
  end
end
