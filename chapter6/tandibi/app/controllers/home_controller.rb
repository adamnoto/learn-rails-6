class HomeController < ApplicationController
  def index
    redirect_to(timelines_path) if user_signed_in?
  end
end
