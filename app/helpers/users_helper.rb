module UsersHelper
  def gravatar_for(user, classes = 'rounded w-10 h-10')
    gravatar_id = Digest::MD5.hexdigest(user.email.downcase)
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}"
    image_tag(gravatar_url, alt: user.name, class: classes)
  end
end
