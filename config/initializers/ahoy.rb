class Ahoy::Store < Ahoy::DatabaseStore
  def store
    res = AuthorizeApiRequest.call(request.headers, false).result
  end

  def store
    store.user
  end

  def track_visit(data)
    if data[:store_id]
      super(data)
    end
  end

  def track_event(data)
    if data[:store_id]
      data[:product_id] = data[:properties][:product_id]
      super(data)
    end
  end
end

# set to true for JavaScript tracking
Ahoy.api = true
Ahoy.api_only = true

# better user agent parsing
Ahoy.user_agent_parser = :device_detector

# better bot detection
Ahoy.bot_detection_version = 2
