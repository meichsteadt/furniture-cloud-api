class CheckUserKey
  class << self
    def check_key(hash)
      @user = UserKey.find_by(key: hash[:key]).authenticate(hash[:secret]).user
      HashWithIndifferentAccess.new JSON.parse(@user.to_json)
    rescue
      return nil
    end
  end
end
