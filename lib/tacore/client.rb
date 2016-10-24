module TACore
  # =>  Client Class methods.
  # Clients are companies, or groups of users that have access to the same data. When making requests it is important to keep the client api_key
  class Client < Auth
    # Get all Clients that belong to this application
    # @example Get all Clients
    #   clients = TACore::Client.all(TACORE_TOKEN)
    # @param token [String] Oauth2 Token after Authentication
    # @return [Array<Object, Object>] in JSON format
    def self.all(token)
      response = request(:get, '/api/v2/application', {headers: {"token": token}})
      return response["clients"]
    end

    # Allows an application to add a Client
    # @example Create a new Client
    #   client = TACore::Client.create(TACORE_TOKEN, {name: "My Client", active: true})
    #   # It is important to store the client["api_key"] after creation.
    # @param token [String] Oauth2 Token after Authentication
    # @param client [Object]
    # @return [Object] in JSON format - the new client
    # @note The new Client will be owned by the application creating it.
    def self.create(token, client = {})
      request(:post, '/api/v2/client', {headers: {"token": token}, body: cient})
    end

    # Get details on a specific client by api_key
    # @example Find a client with an API-KEY
    #   # Using the client api_key as client["api_key"]
    #   client = TACore::Client.find(TACORE_TOKEN, client["api_key"])
    # @param token [String] Oauth2 Token after Authentication
    # @param api_key [String] used from {Client.create}
    # @return [Object] in JSON format
    def self.find(token, client_id)
      #return JSON.parse(make_request('get', '/clients/' + api_key, {:client_api_key => api_key}, {}).body)
      request(:get, '/api/v2/client/', {headers: {"client_id": client_id, "token": token}})
    end

    # Update a client details via api_key
    # @example Update an existing client name using the api_key
    #    # Using the client api_key as client["api_key"]
    #    client = TACore::Client.update(TACORE_TOKEN, client["api_key"], {name: "New Client Name"})
    # @example Update an existing client active status and name using the api_key
    #    # Using the client api_key as client["api_key"]
    #    client = TACore::Client.update(TACORE_TOKEN, client["api_key"], {active: false, name: "Even better name"})
    # @param token [String] Oauth2 Token after Authentication
    # @param api_key [String] used from {Client.create}
    # @param client [Object]
    # @return [Object] in JSON format
    # @note The `client` object currently only supports `name`
    def self.update(token, client_id, client = {})
      request(:put, '/api/v1/clients/', {headers: {"token": token, "client_id": client_id}, body: client})
    end

  end
end
