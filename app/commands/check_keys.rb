class CheckKeys
  prepend SimpleCommand

  def initialize(url, secret)
    @url = url
    @secret = secret
  end

  def call
    JsonWebToken.encode({store_id: store.id, crm: false}) if store
  end

  private

  attr_accessor :url, :secret

  def store
    # binding.pry
    store = Store.find_by_url(Base64.decode64(@url))
    return store if store && Store.first.authenticate(Base64.decode64(secret))

    # used for testing with postman
    # user_url = UserKey.find_by_url(url)
    # return user_url.user if user_url && user_url.authenticate(secret)
    errors.add :user_authentication, 'invalid credentials'
    nil
  end
end
