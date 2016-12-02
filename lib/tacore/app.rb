module TACore
  # => Application class methods
  class App < Auth
    # Get details on a specific application by token
    # @param token [String] Application Token after Authentication
    # @return [Object] in JSON format
    def self.find(token)
      request(:get, '/application/',{}, {"token": token})
    end

    # Get Details on all Applications
    # @param token [String] Application Token after Authentication
    # @return [Object] in JSON format
    def self.all(token)
      request(:get, '/application/all', {}, {"token": token})
    end

    # Get all Iris devices assigned to your application
    # @param token [String] Application Token after Authentication
    # @return [Object] in JSON format
    def self.devices(token)
      request(:get, '/application/iris', {}, {"token": token})
    end

    # Get all Cirrus gateways assigned to your application
    # @param token [String] Application Token after Authentication
    # @return [Object] in JSON format
    def self.gateways(token)
      request(:get, '/application/cirrus', {}, {"token": token})
    end

  end
end
