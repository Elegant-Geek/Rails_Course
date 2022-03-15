module UsersHelper
    def profile_image(user)
        url = "https://secure.gravatar.com/avatar/#{user.gravatar_id}"
        image_tag(url, alt: user.name)
      end
# A more verbose helper that does not display the username in parentheses if it is nil or ""
    def username_display(user)
      case username_input = user.username
      when username_input = ""
      when username_input = nil
      else
        "(#{user.username})"
      end
    end
end
