# THINAER CORE API
#
# => TACore API
#
require 'oauth2'
require 'exceptions'
module TACore
  class Configuration
	    attr_accessor :api_url
      attr_accessor :admin_key
      attr_accessor :client_id
      attr_accessor :client_secret

	    def initialize
	      self.api_url 		= nil
        self.admin_key = nil
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
    attr_accessor :admin_key
    attr_accessor :client_id
    attr_accessor :client_secret
		def api_url
	    	raise "api_url is needed to connect" unless @api_url
	    	@api_url
	  end

    def admin_key
	    	@admin_key
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

  class Auth < Configuration
    attr_accessor :token
    attr_accessor :client

    def initialize
      @client = OAuth2::Client.new(TACore.configuration.client_id, TACore.configuration.client_secret, :site => TACore.configuration.api_url)
    end

    def self.login
      core = TACore::Auth.new
      @@token = core.client.client_credentials.get_token
      if @@token.nil?
        raise "Authentication Failed"
      end
      @@token
    end

    #
    # Request method
    # Example:
    #   request(*1, *2, *3, *4)
    #   *1) [:get, :post, :put, :delete]
    #   *2) 'URI as string'
    #   *3) Authed users token (String)
    #   *4) Body or Header options in hash
    #     *4.1) {:body => {}, :headers => {}}
    #
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

  # => Core Models
  #------------------------------

  class Client < Auth
    def self.create(token, client)
      # => Requres Service Admin Key & Client API Key
      request(:post, '/api/v1/clients', token, {:headers => {:admin_key => TACore.configuration.admin_key}, :body => { :client => client }})
    end

    def self.find(token, api_key)
      #return JSON.parse(make_request('get', '/clients/' + api_key, {:client_api_key => api_key}, {}).body)
      request(:get, '/api/v1/clients/' + api_key, token, {:headers => {:client_api_key => api_key}})
    end

    def self.update(token, api_key, client)
      request(:put, '/api/v1/clients/' + api_key, token, {:body => {:client => client}, :headers => {:client_api_key => api_key}})
    end

    def self.all(token)
      request(:get, '/api/v1/clients/all', token, {:headers => {:admin_key => TACore.configuration.admin_key}})
    end

    def self.destroy(token, api_key)
      request(:delete, '/api/v1/clients/' + api_key, token, {:headers => {:admin_key => TACore.configuration.admin_key, :client_api_key => api_key}})
    end

    def self.activate(token, api_key)
      request(:get, '/api/v1/clients/activate', token, {:headers => {:client_api_key => api_key}})
    end

  end

  class App < Auth
    def self.create(token, app)
      # => Requres Service Admin Key
      request(:post, '/api/v1/apps', token, {:body => {:app => app}, :headers => {:admin_key => TACore.configuration.admin_key}})
    end

    def self.all(token)
      request(:get, '/api/v1/apps/all', token, {:headers => {:admin_key => TACore.configuration.admin_key}})
    end

    def self.find(token, uid)
      request(:get, '/api/v1/apps/' + uid, token, {:headers => {:admin_key => TACore.configuration.admin_key}})
    end

    def self.update(token, uid, app)
      # => Requres Service Admin Key
      request(:put, '/api/v1/apps/' + uid, token, {:body => {:app => app}, :headers => {:admin_key => TACore.configuration.admin_key}})
    end

    def self.destroy(token, uid)
      request(:delete, '/api/v1/apps/' + uid, token, {:headers => {:admin_key => TACore.configuration.admin_key}})
    end
  end

  class Venue < Auth
    def self.create(token, api_key)
      request(:post, '/api/v1/venues', token, {:headers => {:client_api_key => api_key}})
    end

    def self.find(token, api_key, id)
      request(:get, '/api/v1/venues/' + id, token, {:headers => {:client_api_key => api_key}})
    end

    def self.all(token)
      # returns all venues that belong to this client
      request(:get, '/api/v1/venues', token, {:headers => {:client_api_key => api_key}})
    end

    def self.destroy(token, api_key, id)
      request(:delete, '/api/v1/venues/' + id, token, {:headers => {:client_api_key => api_key}})
    end
  end

  class Device < Auth
    def self.unassigned(token, api_key)
      request(:get, '/api/v1/devices/unassigned', token, {:headers => {:client_api_key => api_key}})
    end

    def self.update(token, api_key, id, device = {})
      request(:put, '/api/v1/devices/' + id, token, {:body => {:device => device}, :headers => {:client_api_key => api_key}})
    end

    # => Create and Destroy are for testing only and require the admin_key
    def self.create(token, api_key, device = {})
      request(:post, '/api/v1/devices', token, {:body => {:device => device}, :headers => {:admin_key => TACore.configuration.admin_key, :client_api_key => api_key}})
    end

    def self.destroy(token, api_key, id)
      request(:delete, '/api/v1/devices/' + id, token, {:headers => {:admin_key => TACore.configuration.admin_key, :client_api_key => api_key}})
    end
  end

  class Test < Auth
    def initialize
      puts "This is a test of the TACore GEM"
    end
  end
end
