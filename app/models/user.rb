class User < ActiveRecord::Base
  has_secure_password

  validates :name, presence: true
  validates :email, presence: true, uniqueness: { case_sensitive: false }
  validates :password, length: {minimum: 6}

  def self.authenticate_with_credentials(email, password)
    corrected_email = email.downcase.strip
    @user = User.find_by_email(corrected_email)
    if @user && @user.authenticate(password)
      @user
    else
      nil
    end
  end 

end
