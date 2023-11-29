class User < ApplicationRecord
    #FIGVAPBER
    before_validation :ensure_session_token

    validates :email, :session_token, presence: true, uniqueness: true
    validates :password_digest, presence: true 
    validates :password, length: {minimum: 6, allow_nil: true}

    attr_reader :password 

    def password=(password)
        @password = password 
        self.password_digest = BCrypt::Password.create(password)
    end

    def is_password?(password)
        password_obj = BCrypt::Password.new(self.password_digest)
        password_obj.is_password?(password)
    end
    
end
