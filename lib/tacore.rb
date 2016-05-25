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
      rescue => e
        raise TACore::TokenError.new "#{e.message}"
      end
    end

  end

  require 'tacore/client'
  require 'tacore/venue'
  require 'tacore/device'
  require 'tacore/scan'


  class Test < Auth
    def initialize
      puts "This is a test of the TACore GEM"
    end
  end
end
