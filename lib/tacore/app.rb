module TACore
  # => Application class methods
  class App < Auth
    # Get details on a specific application by token
    # @param token [String] Application Token after Authentication
    # @return [Object] in JSON format
    def self.find(token)
      request(:get, '/application/',{}, {"token": token})
    end

  end
end
