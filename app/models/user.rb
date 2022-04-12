class User < ActiveRecord::Base

  has_secure_password
  validates_length_of :password, minimum: 4
  validates :password_confirmation, presence: true
  validates :email, :uniqueness => {:case_sensitive => false}, presence: true
  validates :first_name, presence: true
  validates :last_name, presence: true

  def self.authenticate_with_credentials(email, password)
    @user = self.find_by_email(email)

    # If the user exists AND the password entered is correct.
    if @user && @user.authenticate(password)
      return @user
    else
      return nil
    end
  end

end
