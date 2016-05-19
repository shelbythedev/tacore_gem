module TACore
  # => Venue is used to group devices for Clients, Venue could be a location or an area within a location.
  # It is important to note that all Venue methods require the use a client api_key see {Client.create}.
  class Venue < Auth
    # Create a new Venue under a Client.
    # @example Create a new Venue for a Client
    #    # Using the client api_key as client["api_key"]
    #    venue = TACore::Venue.create(TACORE_TOKEN, client["api_key"])
    #    venue["id"] #=> 752
    #    # After creation save the venue["id"] for later use.
    # @param token [String] Oauth2 Token after Authentication
    # @param api_key [String] used from {Client.create}
    # @return [Object] in JSON format
    def self.create(token, api_key)
      request(:post, '/api/v1/venues', token, {:headers => {:client_api_key => api_key}})
    end

    # Get back Venue information
    # @param token [String] Oauth2 Token after Authentication
    # @param api_key [String] used from {Client.create}
    # @param key [String] the Key of the Venue from {Venue.create}
    # @return [Object] in JSON format
    def self.find(token, api_key, id)
      request(:get, '/api/v1/venues/' + id.to_s, token, {:headers => {:client_api_key => api_key}})
    end

    # Get all devices assigned to this venue. Also see {Device.update}.
    # @example See all the Devices assigned to a venue with the venue id and device type.
    #    # Using the client api_key as client["api_key"]
    #    # Using the venue key as venue["key"]
    #    devices = TACore::Venue.devices(TACORE_TOKEN, client["api_key"], venue["key"], "cirrus")
    # @example Use Device.device_types to set device_type
    #    # Using the client api_key as client["api_key"]
    #    # Using the venue key as venue["key"]
    #    device_types = TACore::Devices.device_types
    #    devices = TACore::Venue.devices(TACORE_TOKEN, client["api_key"], venue["key"], device_types[:cirrus].first)
    # @param token [String] Oauth2 Token after Authentication
    # @param api_key [String] used from {Client.create}
    # @param key [String] the Key of the Venue from {Venue.create}
    # @param device_type [String] select the device_type see {Device.device_types}
    # @return [Array<Object, Object>] in JSON format
    def self.devices(token, api_key, id, device_type)
      request(:get, '/api/v1/venues/' + id.to_s + '/devices/' + device_type, token, {:headers => {:client_api_key => api_key}})
    end

    # Display all Venues for the client
    # @param token [String] Oauth2 Token after Authentication
    # @param api_key [String] used from {Client.create}
    # @return [Array<Object, Object>] in JSON format
    def self.all(token, api_key)
      # returns all venues that belong to this client
      request(:get, '/api/v1/venues', token, {:headers => {:client_api_key => api_key}})
    end

    # This method will permanently remove the venue from the API.
    # @param token [String] Oauth2 Token after Authentication
    # @param api_key [String] used from {Client.create}
    # @param key [String] the Key of the Venue from {Venue.create}
    # @return [Hash<{"destroy": false, Object}>] in JSON format
    def self.destroy(token, api_key, id)
      request(:delete, '/api/v1/venues/' + id.to_s, token, {:headers => {:client_api_key => api_key}})
    end
  end
end
