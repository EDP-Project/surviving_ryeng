module GuidesHelper
  def user_permitted?(guide)
    guide.user == current_user || current_user.admin? 
  end
end
