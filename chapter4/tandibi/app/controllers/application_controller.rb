class ApplicationController < ActionController::Base
  layout :layout_by_resource

  private

    def layout_by_resource
      devise_controller? ? "session" : "application"
    end

end
