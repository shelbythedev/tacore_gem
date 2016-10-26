module TACore
  # => Venue is used to group devices for Clients, Venue could be a location or an area within a location.
  # It is important to note that all Venue methods require the use a client_id see {Client.create}.
  class Venue < Auth
    # Create a new Venue under a Client.
    # @param token [String] Client Token after Authentication
    # @param client_id [String] used from {Client.create}
    # @param venue [Object] Venue params
    # @note Venue currently only accepts 'name'
    # @return [Object] in JSON format
    def self.create(token, client_id, venue = {})
      request(:post, '/venue', venue, {"client_id" => client_id, "token": token})
    end

    # Get back Venue information
    # @param token [String] Client Token after Authentication
    # @param client_id [String] used from {Client.create}
    # @param venue_id [String] used from {Venue.create}
    # @return [Object] in JSON format
    def self.find(token, client_id, venue_id)
      request(:get, '/venue/' + venue_id.to_s,{}, {"client_id" => client_id, "token": token})
    end

    # @TODO NO LONGER NEEDED?
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
    # @param token [String] Client Token after Authentication
    # @param api_key [String] used from {Client.create}
    # @param key [String] the Key of the Venue from {Venue.create}
    # @param device_type [String] select the device_type see {Device.device_types}
    # @return [Array<Object, Object>] in JSON format
    # def self.devices(token, api_key, id, device_type)
    #   request(:get, '/venues/' + id.to_s + '/devices/' + device_type, token, {:headers => {:client_api_key => api_key}})
    # end

    # Display all Venues for the client
    # @param token [String] Client Token after Authentication
    # @param client_id [String] used from {Client.create}
    # @return [Array<Object, Object>] in JSON format
    def self.all(token, client_id)
      # returns all venues that belong to this client
      request(:get, '/client/venues', {}, {"token": token, "client_id" => client_id})
    end

    # This method will permanently remove the venue from the API.
    # @param token [String] Client Token after Authentication
    # @param client_id [String] used from {Client.create}
    # @param venue_id [String] the Key of the Venue from {Venue.create}
    # @return [Hash, status: 410] in JSON format
    def self.destroy(token, client_id, venue_id)
      request(:delete, '/venue/' + venue_id.to_s,{}, {"client_id" => client_id, "token": token})
    end

    # @TODO NOT IN API
    # Get all proximity scan data (filtered) by venue.
    # @param token [String] Oauth2 Token after Authentication
    # @param api_key [String] used from {Client.create}
    # @param key [String] the Key of the Venue from {Venue.create}
    # @return [Hash] in JSON format
    # def self.scans(token, api_key, id)
    #   request(:get, '/venues/' + id + '/scans', token, {:headers => {:client_api_key => api_key}})
    # end
  end
end
