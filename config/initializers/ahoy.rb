class Ahoy::Store < Ahoy::DatabaseStore
  def store
    res = AuthorizeApiRequest.call(request.headers, false).result
  end

  def store
    store.user
  end

  def track_visit(data)
    if request.parameters[:store_id]
      data[:store_id] = request.parameters[:store_id]
      super(data)
    end
  end

  def track_event(data)
    @visit = Ahoy::Visit.find_by(visit_token: data[:visit_token]) if data[:visit_token]
    if @visit
      data[:store_id] = @visit.store_id
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
