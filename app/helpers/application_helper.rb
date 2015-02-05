module ApplicationHelper
  
  def full_title(specific_page)
    if specific_page.empty?
      'Surviving RyEng'
    else
      "Surviving RyEng | #{specific_page}"
    end
  end

  def gravatar_for(user, options = { size: 50 })
    gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
    size = options[:size]
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}&r=x&default=identicon"
    image_tag(gravatar_url, alt: user.last_name, class: "gravatar")
  end
end
