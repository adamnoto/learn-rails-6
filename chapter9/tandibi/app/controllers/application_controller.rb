class ApplicationController < ActionController::Base
  layout :layout_by_resource
  before_action :config_devise_params, if: :devise_controller?
  before_action :set_locale

  private

    def private_controller?
      return false if controller_path == "home"

      true
    end

    def layout_by_resource
      case
      when devise_controller? then "session"
      when private_controller? then "private"
      else "application"
      end
    end

    def set_locale
      return unless current_user
      I18n.locale = current_user.locale
    end

  protected

    def config_devise_params
      devise_parameter_sanitizer.permit(:sign_up, keys: [
        :first_name,
        :last_name,
        :username,
        :email,
        :password,
        :password_confirmation
      ])
    end

end
