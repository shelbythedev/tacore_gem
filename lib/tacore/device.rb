module TACore
  # => Device class methods
  # All devices are included in this, to get a latest list of supported devices see {Device.device_types}.
  class Device < Auth

    # Show supported Device types
    # @return [Hash]
    def self.device_types
      # @todo This data will soon come from the API itself, and the output is subject to change.
      devices = {:cirrus => ["cirrus"],
                :iris => ["iris"]}
    end

    # Show all devices that DO NOT have a venue_id set
    # @param token [String] Oauth2 Token after Authentication
    # @param api_key [String] used from {Client.create}
    # @param device_type [String] select the device_type see {Device.device_types}
    # @return [Array<Object, Object>] in JSON format
    def self.unassigned(token, api_key, device_type)
      request(:get, '/api/v1/devices/unassigned/' + device_type, token, {:headers => {:client_api_key => api_key}})
    end

    # Device.update is used to set the venue_id.
    # @example Update the Device venue id
    #    # Using the client api_key as client["api_key"]
    #    # Using the device id as device["id"]
    #    # Using the venue id as venue["id"]
    #    device = TACore::Device.update(TACORE_TOKEN, client["api_key"], device["id"], {venue_id: venue["id"]})
    # @param token [String] Oauth2 Token after Authentication
    # @param api_key [String] used from {Client.create}
    # @param id [Integer] see {Device.unassigned} or {Device.all} to get the Device id
    # @param device [Object]
    # @return [Object] in JSON format
    def self.update(token, api_key, id, device = {})
      request(:put, '/api/v1/devices/' + id.to_s, token, {:body => {:device => device}, :headers => {:client_api_key => api_key}})
    end

    # @param token [String] Oauth2 Token after Authentication
    # @param api_key [String] used from {Client.create}
    # @param id [Integer] see {Device.unassigned} or {Device.all} to get the Device id
    # @return [Object] in JSON format
    def self.find(token, api_key, id)
      request(:get, '/api/v1/devices/' + id.to_s, token, {:headers => {:client_api_key => api_key}})
    end

    # Display all devices that belong to this Client by device_type
    # @param token [String] Oauth2 Token after Authentication
    # @param api_key [String] used from {Client.create}
    # @param device_type [String] select the device_type see {Device.device_types}
    # @return [Array<Object, Object>] in JSON format
    def self.all(token, api_key, device_type)
      request(:get, '/api/v1/devices/all/' + device_type, token, {:headers => {:client_api_key => api_key}})
    end

    # Get scan data for this device ID.
    # @param token [String] Oauth2 Token after Authentication
    # @param api_key [String] used from {Client.create}
    # @param id [Integer] see {Device.unassigned} or {Device.all} to get the Device id
    # @param raw [Boolean]
    # @return [Hash<raw=false> | Object<raw=true>] in JSON format
    # @note raw [Boolean] when set to `true` will give the last 10 records of scan data.
    def self.scans(token, api_key, id, raw = false)
      request(:get, '/api/v1/devices/' + id.to_s + '/scans?raw=' + raw.to_s, token, {:headers => {:client_api_key => api_key}})
    end

  end
end
