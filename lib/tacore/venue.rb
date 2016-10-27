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
  end
end
