module TACore
  # => Venue is used to group devices for Clients, Venue could be a location or an area within a location.
  # It is important to note that all Venue methods require the use a client_id see {Client.create}.
  class Venue < Auth
    # Create a new Venue
    # @param token [String] Client Token after Authentication
    # @param venue [Object] Venue params
    # @note Venue currently only accepts 'name'
    # @return [Object] in JSON format
    def self.create(token, venue = {})
      request(:post, '/venue', venue, {"token": token})
    end

    # Update a Venue.
    # @param token [String] Client Token after Authentication
    # @param venue [Object] Venue params
    # @note Venue currently only accepts 'name'
    # @return [Object] in JSON format
    def self.update(token, venue_id, venue = {})
      request(:put, '/venue/' + venue_id.to_s, venue, {"token": token})
    end

    # Get back Venue information
    # @param token [String] Client Token after Authentication
    # @param venue_id [String] used from {Venue.create}
    # @return [Object] in JSON format
    def self.find(token, venue_id)
      request(:get, '/venue/' + venue_id.to_s,{}, {"token": token})
    end

    # Display all Venues for the client
    # @param token [String] Client Token after Authentication
    # @param client_id [String] used from {Client.create}
    # @return [Array<Object, Object>] in JSON format
    def self.all(token)
      # returns all venues that belong to this client
      request(:get, '/venues', {}, {"token": token})
    end

    # This method will permanently remove the venue from the API.
    # @param token [String] Client Token after Authentication
    # @param client_id [String] used from {Client.create}
    # @param venue_id [String] the Key of the Venue from {Venue.create}
    # @return [Hash, status: 410] in JSON format
    def self.destroy(token, venue_id)
      request(:delete, '/venue/' + venue_id.to_s,{}, {"token": token})
    end

    # Get all devices belonging to the given venue
    # @param token [String] Client Token after Authentication
    # @param venue_id [String] the Key of the Venue from {Venue.create}
    # @return [Hash, status: 200] in JSON format
    def self.devices(token, venue_id)
      request(:get, '/venue/' + venue_id.to_s + '/devices',{}, {"token": token})
    end

    # Get all gateways belonging to the given venue
    # @param token [String] Client Token after Authentication
    # @param venue_id [String] the Key of the Venue from {Venue.create}
    # @return [Hash, status: 200] in JSON format
    def self.devices(token, venue_id)
      request(:get, '/venue/' + venue_id.to_s + '/gateways',{}, {"token": token})
    end
  end
end
