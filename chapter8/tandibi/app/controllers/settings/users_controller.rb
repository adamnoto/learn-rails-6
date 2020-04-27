class Settings::UsersController < ApplicationController
  def show
  end

  def update
    current_user.assign_attributes permitted_params
    changes = current_user.changes

    if changes.any?
      if current_user.save
        flash[:notice] = "Profile's settings updated"
      else
        flash[:alert] = "Unable to update the profile settings"
      end
    end

    redirect_to settings_user_path
  end

  private

    def permitted_params
      params.require(:user).permit(
        :username,
        :first_name,
        :last_name,
        :is_public,
      )
    end

end
