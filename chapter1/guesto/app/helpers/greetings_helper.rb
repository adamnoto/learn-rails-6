module GreetingsHelper
  def gravatarized_url(name)
    hash = Digest::MD5.hexdigest(name)
    "https://www.gravatar.com/avatar/#{hash}?d=wavatar"
  end
end
