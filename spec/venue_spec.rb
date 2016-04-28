require 'spec_helper'

describe TACore do

  context "Create and Destroy Venue" do
    it "create and destroy" do
      venue = TACore::Venue.create(TOKEN, TEST_CLIENT_KEY)
      expect(venue["key"]).to_not eq(nil)

      client = TACore::Client.find(TOKEN, TEST_CLIENT_KEY)
      expect(venue["client_id"]).to eq(client["id"])

      venue = TACore::Venue.destroy(TOKEN, TEST_CLIENT_KEY, venue["id"])
      expect(venue).to_not eq(false)
    end
  end

  context "Find Venue" do
    it "get venue by ID" do
      venue = TACore::Venue.create(TOKEN, TEST_CLIENT_KEY)
      expect(venue["key"]).to_not eq(nil)

      venue_data = TACore::Venue.find(TOKEN, TEST_CLIENT_KEY, venue["id"])
      expect(venue["id"]).to eq(venue_data["id"])

      # => Cleanup
      venue = TACore::Venue.destroy(TOKEN, TEST_CLIENT_KEY, venue["id"])
      expect(venue).to_not eq(false)
    end
  end

end
