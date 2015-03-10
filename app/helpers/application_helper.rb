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

  def attachment_icon_for(a)
    ext = a.upload_file_name.last(6)
    type = a.upload_content_type
    file_icon = {
      code:     "<i class='fa fa-file-code-o fa-2x'></i>".html_safe,
      img:      "<i class='fa fa-file-photo-o fa-2x'></i>".html_safe,
      video:    "<i class='fa fa-file-video-o fa-2x'></i>".html_safe,
      audio:    "<i class='fa fa-file-audio-o fa-2x'></i>".html_safe,
      archive:  "<i class='fa fa-file-archive-o fa-2x'></i>".html_safe,
      text:     "<i class='fa fa-file-text-o fa-2x'></i>".html_safe,
      excel:    "<i class='fa fa-file-excel-o fa-2x'></i>".html_safe,
      msword:   "<i class='fa fa-file-word-o fa-2x'></i>".html_safe,
      ppt:      "<i class='fa fa-file-powerpoint-o fa-2x'></i>".html_safe,
      pdf:      "<i class='fa fa-file-pdf-o fa-2x'></i>".html_safe,
      default:  "<i class='fa fa-file-o fa-2x'></i>".html_safe
    }

    code_e = [".c", ".cpp", ".js", ".rb", ".py", ".m", ".vb", ".cs", ".class"]
    archive_e = [".zip", ".rar", ".7z"]

    if type.include? "image"
      file_icon[:img]
    elsif type.include? "video"
      file_icon[:video]
    elsif type.include? "audio"
      file_icon[:audio]
    elsif archive_e.any? { |e| ext.include?(e) }
      file_icon[:archive]
    elsif ext.include? ".txt"
      file_icon[:text]
    elsif ext.include? ".xls"
      file_icon[:excel]
    elsif (ext.include? ".doc") || (ext.include? ".docx")
      file_icon[:msword]
    elsif ext.include? ".ppt"
      file_icon[:ppt]
    elsif ext.include? ".pdf"
      file_icon[:pdf]
    elsif code_e.any? { |e| ext.include?(e) }
      file_icon[:code]
    else
      file_icon[:default]
    end  

  end

  def permitted_to_modify?(resource)
    resource.user == current_user || current_user.admin? 
  end

  def liked?(resource)
    Like.where(likeable: resource, liker_id: current_user.id).present?
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
