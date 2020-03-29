class HomeController < ApplicationController
  def index
    return redirect_to(timelines_path) if user_signed_in?
  end
end
