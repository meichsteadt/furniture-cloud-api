class CheckKeys
  prepend SimpleCommand

  def initialize(key, secret)
    @key = key
    @secret = secret
  end

  def call
    JsonWebToken.encode({user_id: user.id, crm: false}) if user
  end

  private

  attr_accessor :key, :secret

  def user
    user_key = UserKey.find_by_key(Base64.decode64(key))
    return user_key.user if user_key && user_key.authenticate(Base64.decode64(secret))

    # used for testing with postman
    # user_key = UserKey.find_by_key(key)
    # return user_key.user if user_key && user_key.authenticate(secret)
    errors.add :user_authentication, 'invalid credentials'
    nil
  end
end
