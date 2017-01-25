module TACore
  # => Gateway class methods
  class Gateway < Auth
    # Shows the devices that are seen by the gateway id
    # @param token [String] Client Token after Authentication
    # @param client_id [String] used from {Client.create}
    # @param gateway_id [String] Gateway ID
    # @return [Array<Object, Object>] in JSON format
    def self.sees(token, client_id, gateway_id)
      request(:get, '/gateway/' + gateway_id.to_s + '/sees', {}, {token: token, "client-id" => client_id})
    end

    # Gets the Gateway by ID
    # @param token [String] Client Token after Authentication
    # @param client_id [String] used from {Client.create}
    # @param gateway_id [String] Gateway ID
    # @return [Array<Object, Object>] in JSON format
    def self.find(token, client_id, gateway_id)
      request(:get, '/gateway/' + gateway_id.to_s, {}, {token: token, "client-id" => client_id})
    end

    # Updates Gateway venue_id
    # @param token [String] Client Token after Authentication
    # @param client_id [String] used from {Client.create}
    # @param gateway_id [String] Gateway ID
    # @param gateway [Object]
    # @return [Array<Object, Object>] in JSON format
    def self.update(token, client_id, gateway_id, gateway = {})
      request(:put, '/gateway/' + gateway_id.to_s, gateway, {token: token, "client-id" => client_id})
    end

  end
end
