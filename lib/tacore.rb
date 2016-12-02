# THINAER Core API GEM
#
# Author::    Greg Winn (greg.winn@thinaer.io)
# Copyright:: Copyright (c) 2016 Advantix ThinAer, LLC
# License::   NONE

require 'rest-client'
require 'exceptions'
require 'net/http'
require 'uri'
require 'json'

# This module holds every public class and method need to
# to authenticate and configure the TACore GEM
module TACore

  # Configuration of the config params set in an init file.
  class Configuration
	    attr_accessor :api_url
      attr_accessor :client_id
      attr_accessor :client_secret
      attr_accessor :api_key

	    def initialize
	      self.api_url 		= nil
        self.client_id       = nil
        self.client_secret   = nil
        self.api_key   = nil
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
    attr_accessor :api_key
    def api_key
      raise "api_key is needed to connect" unless @api_key
      @api_key
    end

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

  # Authorization class that will create the client token and authenticate with the API
  class Auth < Configuration
    attr_accessor :token
    attr_accessor :client

    # Used to retrieve the TOKEN and Authenticate the application
    def self.login

      # use rest-client for auth post to get token
      @@token = RestClient::Request.execute(method: :post, url: TACore.configuration.api_url + "/application/token",
        headers: {
            "uid": TACore.configuration.client_id,
            "secret": TACore.configuration.client_secret,
            "x-api-key": TACore.configuration.api_key
        }
      )

      if JSON.parse(@@token).include? "error"
        # The responce included an error, stop and show it!
        raise JSON.parse(@@token)["error"]
      end

      if @@token.nil?
        raise "Authentication Failed"
      end
      JSON.parse(@@token)
    end

    # Internal request only.
    # Request method
    # @param method [Symbol<:get, :post, :put, :delete>]
    # @param uri [String]
    # @param payload [Hash] Changes to document object (optional)
    # @param headers [Hash] token, client_id,...
    def self.request(method, uri, payload, headers)

      # Add static API-KEY to headers from config
      headers["x-api-key"] = TACore.configuration.api_key

      begin
        response = RestClient::Request.execute(method: method, url: TACore.configuration.api_url + uri, payload: payload, headers: headers)
        case response.code
        when 200
          JSON.parse(response.body)
        else
          return { "error": { "code": response.code, "body": JSON.parse(response.body) }}
        end

      # Rest Client exceptions
      rescue RestClient::ExceptionWithResponse => e
        # Raise TokenError on all other exceptions
        raise TACore::TokenError.new "#{e.message}"

      # Rescue for unauthorized/token expired
      rescue AuthenticationError
        self.login
      # Rescue from rest-client exception due to 410 status from deleted objects
      rescue NotThereError
        {deleted: true}
      end
    end

  end

  require 'tacore/client'
  require 'tacore/venue'
  require 'tacore/device'
  require 'tacore/gateway'
  require 'tacore/app'


  class Test < Auth
    def initialize
      puts "This is a test of the TACore GEM"
    end
  end
end
