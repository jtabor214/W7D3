class User < ApplicationRecord
    #FIGVAPEBR
    #find_by credentials/is_password?/generate_session_token/validates/attr_reader/password=/ensure_session_token/before_validation/reset_session_token!
    before_validation :ensure_session_token

    validates :email, :session_token, presence: true, uniqueness: true
    validates :password_digest, presence: true 
    validates :password, length: {minimum: 6, allow_nil: true}

    def self.find_by_credentials(email, password) 
        @user = User.find_by(email: email)
        if @user && @user.is_password?(password)
            @user
        else
            nil 
        end 
    end 

    attr_reader :password 

    def password=(password)
        @password = password 
        self.password_digest = BCrypt::Password.create(password)
    end

    def is_password?(password)
        password_obj = BCrypt::Password.new(self.password_digest)
        password_obj.is_password?(password)
    end
    
    def ensure_session_token
        self.session_token ||= SecureRandom::urlsafe_base64
        # self.session_token ||= generate_unique_session_token <line33-35>
    end 

    def reset_session_token!
        self.session_token = SecureRandom::urlsafe_base64
        self.save!
        self.session_token
    end 

    # def generate_unique_session_token
    #     SecureRandom::urlsafe_base64
    # end 
end
