class AuthenticateUser
  prepend SimpleCommand

  def initialize(email, password)
    @email = email
    @password = password
  end

  def call
    JsonWebToken.encode({user_id: user.id, crm: true}) if user
  end

  private

  attr_accessor :email, :password

  def user
    user = User.find_by_email(Base64.decode64(email))
    return user if user && user.authenticate(Base64.decode64(password))

    errors.add :user_authentication, 'invalid credentials'
    nil
  end
end
