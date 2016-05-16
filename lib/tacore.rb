# THINAER Core API GEM
#
# Author::    Greg Winn (greg.winn@thinaer.io)
# Copyright:: Copyright (c) 2016 Advantix ThinAer, LLC
# License::   NONE

require 'oauth2'
require 'exceptions'

# This module holds every public class and method need to
# to authenticate and configure the TACore GEM
module TACore

  # Configuration of the config params set in an init file.
  class Configuration
	    attr_accessor :api_url
      attr_accessor :client_id
      attr_accessor :client_secret

	    def initialize
	      self.api_url 		= nil
        self.client_id       = nil
        self.client_secret   = nil
	    end
	end

	def self.configuration
	  @configuration ||=  Configuration.new
	end

	def self.configure
	  yield(configuration) if block_given?
	end

	class << self
		attr_accessor :api_url
    attr_accessor :client_id
    attr_accessor :client_secret
		def api_url
	    	raise "api_url is needed to connect" unless @api_url
	    	@api_url
	  end

    def client_id
	    	raise "client_id is needed to connect" unless @client_id
	    	@client_id
	  end

    def client_secret
	    	raise "client_secret is needed to connect" unless @client_secret
	    	@client_secret
	  end
	end

  # Authorization class that will create the OAuth2 token and authenticate with the API
  class Auth < Configuration
    attr_accessor :token
    attr_accessor :client

    def initialize
      @client = OAuth2::Client.new(TACore.configuration.client_id, TACore.configuration.client_secret, :site => TACore.configuration.api_url)
    end

    # Used to retrive the TOKEN after Authentication
    # @return [Oauth2 Object]
    def self.login
      core = TACore::Auth.new
      @@token = core.client.client_credentials.get_token
      if @@token.nil?
        raise "Authentication Failed"
      end
      @@token
    end

    # Internal request only.
    # Request method
    # @param method [Symbol<:get, :post, :put, :delete>]
    # @param uri [String]
    # @param token [String] Oauth2 Token after Authentication
    # @param options [Hash<{:headers => {}, :body => {}}>]
    def self.request(method, uri, token, options = {})
      core = TACore::Auth.new
      begin
        access = OAuth2::AccessToken.new(core.client, token)
        JSON.parse(access.request(method, TACore.configuration.api_url + uri, options).body)
      rescue
        raise TACore::TokenError.new "Error, Token expired or external API is not responding."
      end
    end

  end

  # Client Class used for client method requests.
  class Client < Auth
    # Get all Clients that belong to this application
    # @param token [String] Oauth2 Token after Authentication
    # @return [Array<Object, Object>] in JSON format
    def self.all(token)
      request(:get, '/api/v1/clients', token)
    end
    # Allows an application to add a Client
    # @param token [String] Oauth2 Token after Authentication
    # @param client [Object]
    # @return [Object] in JSON format - the new client
    # @note The new Client will be owned by the application creating it.
    def self.create(token, client = {})
      request(:post, '/api/v1/clients', token, {:body => {:client => client}})
    end

    # Get details on a specific client by api_key
    # @param token [String] Oauth2 Token after Authentication
    # @param api_key [String] used from {Client.create}
    # @return [Object] in JSON format
    def self.find(token, api_key)
      #return JSON.parse(make_request('get', '/clients/' + api_key, {:client_api_key => api_key}, {}).body)
      request(:get, '/api/v1/clients/' + api_key, token, {:headers => {:client_api_key => api_key}})
    end

    # Update a client details via api_key
    # @param token [String] Oauth2 Token after Authentication
    # @param api_key [String] used from {Client.create}
    # @param client [Object]
    # @return [Object] in JSON format
    # @note The `client` object currently only supports `name`
    def self.update(token, api_key, client = {})
      request(:put, '/api/v1/clients/' + api_key, token, {:body => {:client => client}, :headers => {:client_api_key => api_key}})
    end

  end


  # => Venue is used to group devices fro Clients, Venue could be a location or an area within a location.
  class Venue < Auth
    # Create a new Venue under a Client.
    # @param token [String] Oauth2 Token after Authentication
    # @param api_key [String] used from {Client.create}
    # @return [Object] in JSON format
    def self.create(token, api_key)
      request(:post, '/api/v1/venues', token, {:headers => {:client_api_key => api_key}})
    end

    # Get back Venue information
    # @param token [String] Oauth2 Token after Authentication
    # @param api_key [String] used from {Client.create}
    # @param id [Integer] the id of the Venue from {Venue.create}
    # @return [Object] in JSON format
    def self.find(token, api_key, id)
      request(:get, '/api/v1/venues/' + id.to_s, token, {:headers => {:client_api_key => api_key}})
    end

    # Get all devices assigned to this venue. Also see {Device.update}.
    # @param token [String] Oauth2 Token after Authentication
    # @param api_key [String] used from {Client.create}
    # @param id [Integer] the id of the Venue from {Venue.create}
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

    # @param token [String] Oauth2 Token after Authentication
    # @param api_key [String] used from {Client.create}
    # @param id [Integer] the id of the Venue from {Venue.create}
    # @return [Hash<{"destroy": false, Object}>] in JSON format
    def self.destroy(token, api_key, id)
      request(:delete, '/api/v1/venues/' + id.to_s, token, {:headers => {:client_api_key => api_key}})
    end
  end

  class Device < Auth

    # Show supported Device types
    # @return [Hash]
    def self.device_types
      devices = {:cirrus => ["cirrus"],
                :iris => ["iris"]}
    end

    # Show all devices that DO NOT have a venue_id set
    # @param token [String] Oauth2 Token after Authentication
    # @param api_key [String] used from {Client.create}
    # @param device_type [String] select the device_type see {Device.device_types}
    # @return [Array<Object, Object>] in JSON format
    def self.unassigned(token, api_key, device_type)
      request(:get, '/api/v1/devices/unassigned/' + device_type, token, {:headers => {:client_api_key => api_key}})
    end

    # Device.update is used to set the venue_id.
    # @param token [String] Oauth2 Token after Authentication
    # @param api_key [String] used from {Client.create}
    # @param id [Integer] see {Device.unassigned} or {Device.all} to get the Device id
    # @param device [Object]
    # @return [Object] in JSON format
    def self.update(token, api_key, id, device = {})
      request(:put, '/api/v1/devices/' + id.to_s, token, {:body => {:device => device}, :headers => {:client_api_key => api_key}})
    end

    # @param token [String] Oauth2 Token after Authentication
    # @param api_key [String] used from {Client.create}
    # @param id [Integer] see {Device.unassigned} or {Device.all} to get the Device id
    # @return [Object] in JSON format
    def self.find(token, api_key, id)
      request(:get, '/api/v1/devices/' + id.to_s, token, {:headers => {:client_api_key => api_key}})
    end

    # Display all devices that belong to this Client by device_type
    # @param token [String] Oauth2 Token after Authentication
    # @param api_key [String] used from {Client.create}
    # @param device_type [String] select the device_type see {Device.device_types}
    # @return [Array<Object, Object>] in JSON format
    def self.all(token, api_key, device_type)
      request(:get, '/api/v1/devices/all/' + device_type, token, {:headers => {:client_api_key => api_key}})
    end

  end

  class Test < Auth
    def initialize
      puts "This is a test of the TACore GEM"
    end
  end
end
