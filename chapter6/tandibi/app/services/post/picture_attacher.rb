class Post::PictureAttacher < ApplicationService
  attr_reader :post, :blob_arg
  private :post, :blob_arg

  def initialize(post, blob_arg)
    @post = post
    @blob_arg = blob_arg
  end

  def call
    if blob_arg.is_a?(ActionDispatch::Http::UploadedFile)
      handle_from_file_upload
    end
  end

  private

    def handle_from_file_upload
      picture = post.pictures.build
      picture.file.attach(blob_arg)
      picture.save!
    end

end
