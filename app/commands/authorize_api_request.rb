class AuthorizeApiRequest
  prepend SimpleCommand

  def initialize(headers = {}, crm = false)
    @headers = headers
    @crm = crm
  end

  def call
    user
  end

  private

  attr_reader :headers, :crm

  def user
    if @crm
      if decoded_auth_token && decoded_auth_token[:crm]
        @user ||= User.find(decoded_auth_token[:user_id])
      end
    else
        if decoded_auth_token
          @user ||= User.find(decoded_auth_token[:user_id])
        end
    end
    @user || errors.add(:token, 'Invalid token') && nil
  end

  def decoded_auth_token
    @decoded_auth_token ||= JsonWebToken.decode(http_auth_header)
  end

  def http_auth_header
    if headers['Authorization'].present?
      return headers['Authorization'].split(' ').last
    else
      errors.add(:token, 'Missing token')
    end
    if headers['SiteAuth'].present?
      return headers['SiteAuth'].split(' ').last
    else
      errors.add(:token, 'Missing token')
    end
    nil
  end
end
