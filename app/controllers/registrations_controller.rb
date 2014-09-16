class RegistrationsController < Devise::RegistrationsController
protected
# def after_sign_up_path_for(resource)
# new_user_session_path
# end
# def after_sign_in_path_for(resource)
# new_argument_path
# end
private
def sign_up_params
params.require(:user).permit(:first_name,:last_name,:username,
:email,:password,:password_confirmation, :about_me)
end
def account_update_params
params.require(:user).permit(:first_name,:last_name,:email,:password,
:password_confirmation,:current_password, :about_me)
end
end