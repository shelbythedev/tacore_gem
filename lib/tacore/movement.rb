module TACore
  # => Device Movement information
  # The Movement class allows you to see movement information from both the Gateway and Iris device.
  class Movement < Auth
    # @example Select all movement data by a Gateway ID
    #    movements = TACore::Movement.by_device(token, api_key, 6)
    #    # => [{"iris_id"=>1, "time_spent"=>"0.52", "created_at"=>"2016-06-10T01:05:16.000Z"}, {"iris_id"=>2, "time_spent"=>"2.08", "created_at"=>"2016-06-10T01:05:19.000Z"}]
    #    # @param time_spent [Float] This is the time spent at the Gateway device in minutes.
    #
    # @example Select the movement data from an Asset Beacon ID
    #    movements = TACore::Movement.by_device(token, api_key, 1)
    #    # => [{"cirrus_id"=>6, "time_spent"=>"0.52", "created_at"=>"2016-06-10T01:05:16.000Z"}]
    # @param token [String] Oauth2 Token after Authentication
    # @param api_key [String] used from {Client.create}
    # @param device_id [Integer] This can be any device_id (Gateway or Asset Beacon)
    # @return [Hash]
    def self.by_device(token, api_key, device_id)
      request(:get, '/api/v1/devices/' + device_id.to_s + '/movements', token, {:headers => {:client_api_key => api_key}})
    end
  end
end
