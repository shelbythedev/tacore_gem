module TACore
  # => Device class methods
  class Device < Auth

    # Device.update is used to set the venue_id.
    # @example Update the Device venue id
    #    # Using the client api_key as client["api_key"]
    #    # Using the device id as device["id"]
    #    # Using the venue id as venue["key"]
    #    device = TACore::Device.update(TACORE_TOKEN, client["api_key"], device["id"], {venue_key: venue["key"]})

    # Update a device's venue_id
    # @param token [String] Client Token after Authentication
    # @param api_key [String] used from {Client.create}
    # @param id [Integer] Device ID
    # @param device [Object] Venue ID as a value
    # @return [Object] in JSON format
    def self.update(token, client_id, device_id, device = {})
      request(:put, '/device/' + device_id.to_s, device, {"client-id" => client_id, "token": token})
    end

    # Find device by device_id
    # @param token [String] Client Token after Authentication
    # @param client_id [String] used from {Client.create}
    # @param device_id [Integer] Device ID
    # @return [Object] in JSON format
    def self.find(token, client_id, device_id)
      request(:get, '/device/' + device_id.to_s,{}, {"client-id" => client_id, "token": token})
    end

    # Display all devices that belong to this Client
    # @param token [String] Client Token after Authentication
    # @param client_id [String] used from {Client.create}
    # @return [Array<Object, Object>] in JSON format
    def self.all(token, client_id)
      request(:get, '/client/devices/', {}, {token: token, "client-id" => client_id})
    end

  end
end
