class Post::Creator < ApplicationService
  attr_accessor :creator, :params, :post
  private :creator, :params, :post

  def initialize(creator, params)
    @creator = creator
    @params = params
    @post = Post.new
  end

  def call
    case postable_type
    when "Status" then create_a_status_update
    else false
    end
  rescue
    false
  end

  private

    def postable_type
      @postable_type ||= params.fetch(:postable_type)
    end

    def status_text
      @status_text ||= params.fetch(:status_text)
    end

    def thread
      @thread ||= begin
        thread_id = params[:thread_id].presence
        Post.find(thread_id) if thread_id
      end
    end

    def create_a_status_update
      status = Status.new(text: status_text)
      post.postable = status
      post.user = creator
      post.thread = thread
      post.save

      post.persisted?
    end

end
