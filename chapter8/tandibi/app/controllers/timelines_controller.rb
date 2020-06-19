class TimelinesController < ApplicationController
  def index
    @posts = Post.not_reply.where(user_id: [
      current_user.id,
      *current_user.followings.pluck(:id)
    ]).includes(postable: [:place]).order("created_at DESC")
  end

  def show
    @posts = Post.of(params[:username])
      .not_reply
      .order("created_at DESC")
  end
end
