# frozen_string_literal: true

module UserDecorator
  def name
    if last_name
      "#{first_name} #{last_name}"
    else
      first_name
    end
  end

  def profile_picture_url
    @profile_picture_url ||= begin
      hash = Digest::MD5.hexdigest(email)
      "https://www.gravatar.com/avatar/#{hash}?d=wavatar"
    end
  end
end
