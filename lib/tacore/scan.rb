module TACore
  # => Scan / Proximity Data.
  # The scan data returned is filtered for duplicates along with ordered for what device is most near in a given group.
  # A group is defined by an array of Gateway device id's (Cirrus id's).
  # @note A group should not include a "beacon" (asset tag) / Iris id, only Gateway device id's should be used to search for proximity data. Using an Iris ID will result in a nil or empty return.
  class Scan < Auth
    # This will return all scan data for a group or single Cirrus ID used.
    # @example Send a group of Cirrus Id's
    #    cirrus_ids = [20, 55, 90]
    #    scans = TACore::Scan.by_cirrus(TACORE_TOKEN, client["api_key"], cirrus_ids)
    #    scans.each do |scan|
    #        puts scan
    #        # => [7,10,55]
    #    end
    # @note To avoid showing duplicate data it's best to use a group of device_id's.
    # @todo Notes and diagram how duplication occurs in scan data while not using a group.
    # @param token [String] Oauth2 Token after Authentication
    # @param api_key [String] used from {Client.create}
    # @param cirrus [Array<Integer>, Integer]
    # @return [Hash] in JSON format
    def self.by_cirrus(token, api_key, cirrus)
      request(:post, '/api/v1/scans', token, {:body => {:devices => cirrus}, :headers => {:client_api_key => api_key}})
    end
  end

end
