class CheckKeys
  prepend SimpleCommand

  def initialize(headers = {})
    @headers = headers
  end

  def call
    user
  end

  private

  attr_reader :headers

  def user
    @user ||= User.find(check_key[:id]) if check_key
    @user || errors.add(:token, 'Invalid headers') && nil
  end

  def check_key
    @checked_key ||= CheckUserKey.check_key(http_auth_header)
  end

  def http_auth_header
    if headers['UserKey'].present? && headers['UserSecret'].present?
      return {key: Base64.decode64(headers['UserKey'].split(' ').last), secret: Base64.decode64(headers['UserSecret'].split(' ').last)}
    else
      errors.add(:token, 'Missing headers')
    end
    nil
  end
end
