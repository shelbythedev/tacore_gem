module TACore
  # => Device class methods
  class Device < Auth

    # Update a device's venue_id
    # @param token [String] Client Token after Authentication
    # @param client_id [String] used from {Client.create}
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
      request(:get, '/client/devices/', {}, {"token": token, "client-id" => client_id})
    end

    # Display all iris devices that belong to this application
    # @param token [String] Client Token after Authentication
    # @return [Array<Object, Object>] in JSON format
    def self.iris(token)
      request(:get, '/application/iris', {}, {"token": token})
    end

    # Display all cirrus devices that belong to this application
    # @param token [String] Client Token after Authentication
    # @return [Array<Object, Object>] in JSON format
    def self.cirrus(token)
      request(:get, '/application/cirrus', {}, {"token": token})
    end

  end
end
