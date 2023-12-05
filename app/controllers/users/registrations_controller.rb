class Users::RegistrationsController < Devise::RegistrationsController
  skip_before_action :authenticate_user!, only: %i[new create]
  before_action :set_resource, only: %i[edit_email update_email edit_password update_password]

  def update
    if current_user.update_without_password(profile_params)
      flash[:notice] = "Successfully updated user"
    else
      flash[:alert] = "There was an error updating the user."
    end
    redirect_to edit_user_registration_path
  end

  def edit_password
    render :edit_password
  end

  def update_password
    if current_user.update_with_password(password_params)
      flash[:notice] = "Successfully updated password. Please sign in again with your new password."
      sign_out(current_user)
      redirect_to new_user_session_path
    else
      flash[:alert] = "There was an error updating the password."
      redirect_to edit_password_user_registration_path
    end
  end

  def edit_email
    render :edit_email
  end

  def update_email
    if current_user.update_with_password(email_params)
      flash[:notice] = "Successfully updated email. Please check your email (#{email_params[:email]}) to confirm."
    else
      flash[:alert] = "There was an error updating the email."
    end
    redirect_to edit_email_user_registration_path
  end

  private

  def set_resource
    self.resource = current_user
  end

  def profile_params
    params.require(:user).permit(
      :ai_generated_content,
    )
  end

  def password_params
    params.require(:user).permit(:current_password, :password, :password_confirmation)
  end

  def email_params
    params.require(:user).permit(:current_password, :email)
  end
end
