module ApplicationHelper
    def avatar_url(user)
        gravatar_id = Digest::MD5::hexdigest(user.email).downcase
        "http://gravatar.com/avatar/#{gravatar_id}.png"
    end

    def resource_name
        :user
    end

    def resource_class 
        User 
    end

    def resource
        @resource ||= User.new
    end

    def devise_mapping
        @devise_mapping ||= Devise.mappings[:user]
    end
end
