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
    image_tag(gravatar_url, alt: user.username, class: "gravatar")
  end

  def attachment_icon_for(attachment)
    
    case attachment.upload_content_type
    when nil

    else
      "<i class='fa fa-file-o fa-2x'></i>".html_safe
    end  

  end

  def permitted_to_modify?(resource)
    resource.user == current_user || current_user.admin? 
  end

  def course_image(course)

    case course.course_code[0..2]
    when "AER"
      image_tag "AER.png", class: 'img-responsive thumbnail'
    when "BLG"
      image_tag "BLG.png", class: 'img-responsive thumbnail', class: 'img-responsive thumbnail'
    when "BME"
      image_tag "BME.png", class: 'img-responsive thumbnail' 
    when "CEN"
      image_tag "CEN.png", class: 'img-responsive thumbnail'
    when "CHE"
      image_tag "CHE.png", class: 'img-responsive thumbnail' 
    when "CHY"
      image_tag "CHY.png", class: 'img-responsive thumbnail'
    when "CMN"
      image_tag "CMN.png", class: 'img-responsive thumbnail' 
    when "COE"
      image_tag "COE.jpg", class: 'img-responsive thumbnail'
    when "CPS"
      image_tag "CPS.png", class: 'img-responsive thumbnail' 
    when "CVL"
      image_tag "CVL.png", class: 'img-responsive thumbnail'
    when "ECN"
      image_tag "ECN.png", class: 'img-responsive thumbnail' 
    when "ELE" || "EES"
      image_tag "ELE_EES.png", class: 'img-responsive thumbnail'
    when "ENG"
      image_tag "ENG.png", class: 'img-responsive thumbnail' 
    when "GEO"
      image_tag "GEO.png", class: 'img-responsive thumbnail'
    when "HST"
      image_tag "HST.png", class: 'img-responsive thumbnail' 
    when "IND"
      image_tag "IND.png", class: 'img-responsive thumbnail'
    when "MEC"
      image_tag "MEC.png", class: 'img-responsive thumbnail' 
    when "MTH"
      image_tag "MTH.png", class: 'img-responsive thumbnail'
    when "PCS"
      image_tag "PCS.png", class: 'img-responsive thumbnail' 
    when "PHL"
      image_tag "PHL.png", class: 'img-responsive thumbnail'
    when "POL"
      image_tag "POL.png", class: 'img-responsive thumbnail' 
    when "PSY"
      image_tag "PSY.png", class: 'img-responsive thumbnail'
    when "WKT"
      image_tag "WKT.png", class: 'img-responsive thumbnail' 
    else
      image_tag "George_Vari.jpg", class: 'img-responsive thumbnail'
    end
  end
end
