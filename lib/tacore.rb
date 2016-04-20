# THINAER CORE API
#
# => TACore API
#
require 'json'
require 'rest-client'
module TACore
  class Configuration
	    attr_accessor :api_url
      attr_accessor :admin_key
	    def initialize
	      self.api_url 		= nil
        self.admin_key = nil
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
		def api_url
	    	raise "api_url is needed to connect" unless @api_url
	    	@api_url
	  end

    def admin_key
	    	raise "admin_key is needed to connect" unless @admin_key
	    	@admin_key
	  end
	end

  class Auth < Configuration
    def self.make_request(method, path, options = {}, payload = {})
      RestClient::Request.execute(method: method.to_sym, url: TACore.configuration.api_url + path, payload: payload, headers: options, verify_ssl: false)
    end
  end

  # => Core Models
  #------------------------------

  class Client < Auth
    def self.create(client, app_id)
      # => Requres Service Admin Key & Client API Key
      return JSON.parse(make_request('post', '/clients', {:admin_key => TACore.configuration.admin_key}, { :client => {:api_key => client["api_key"], :app_id => app_id } }).body)
    end

    def self.find(api_key)
      return JSON.parse(make_request('get', '/clients/' + api_key, {:client_api_key => api_key}, {}).body)
    end

    def self.destroy(api_key)
      return JSON.parse(make_request('delete', '/clients/' + api_key, {:client_api_key => api_key}, {}).body)
    end

  end

  class App < Auth
    def self.create(app)
      # => Requres Service Admin Key
      return JSON.parse(make_request('post', '/apps', {:admin_key => TACore.configuration.admin_key}, { :app => app }).body)
    end

    def self.get(id)
      return JSON.parse(make_request('get', '/apps/' + id.to_s, {:admin_key => TACore.configuration.admin_key}, {}).body)
    end

    def self.all
      # => Requres Service Admin Key
      return JSON.parse(make_request('get', '/apps/all', {:admin_key => TACore.configuration.admin_key}, {}).body)
    end

    def self.destroy(id)
      return JSON.parse(make_request('delete', '/apps/' + id, {:admin_key => TACore.configuration.admin_key}, {}).body)
    end
  end

  class Venue < Auth
    def self.create(client)
      return JSON.parse(make_request('post', '/venues', {:client_api_key => client}, {}).body)
    end

    def self.destroy(client, venue)
      return JSON.parse(make_request('delete', '/venues/' + venue, {:client_api_key => client}, {}).body)
    end
  end

  class Test < Auth
    def initialize
      puts "This is a test of the TACore GEM"
    end
  end
end
