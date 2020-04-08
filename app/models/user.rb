# 
class User < ApplicationRecord
    has_many :posts
    attr_accessor :remember_token
    before_save {self.email = email.downcase}
    validates :username,  presence: true, length: { maximum: 50 }
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    validates :email, presence: true, length: { maximum: 255 },
                      format: { with: VALID_EMAIL_REGEX },
                      uniqueness: { case_sensitive: false }
    has_secure_password
    before_create {self.remember}


    def remember
         self.remember_digest = User.new_token
    end

    def User.new_token
        # create a sha1 encrypted token
         Digest::SHA1.hexdigest(SecureRandom.urlsafe_base64.to_s)
    end

    def authenticated?(remember_token)
        BCrypt::Password.new(remember_digest).is_password?(remember_token)
    end

end
