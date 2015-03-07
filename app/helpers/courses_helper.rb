module CoursesHelper

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
