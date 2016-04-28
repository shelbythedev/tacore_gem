require 'spec_helper'

describe TACore do

  context "Find Devices" do
    it "look at all unassigned to a venue" do
      devices = TACore::Device.unassigned(TOKEN, TEST_CLIENT_KEY)
      expect(devices).to_not eq(nil)
    end
  end

  context "Update Device with Venue" do
    it "create a new device then update the venue" do
      device = TACore::Device.create(TOKEN, TEST_CLIENT_KEY, {:venue_id => 0})
      expect(device["id"]).to_not eq(nil)

      device = TACore::Device.update(TOKEN, TEST_CLIENT_KEY, device["id"].to_s, {:venue_id => 1})
      expect(device["venue_id"]).to eq(1)

      destroy = TACore::Device.destroy(TOKEN, TEST_CLIENT_KEY, device["id"].to_s)
      expect(destroy).to_not eq(false)
    end

    it "set device venue_id to nil" do
      device = TACore::Device.create(TOKEN, TEST_CLIENT_KEY, {:venue_id => 0})
      expect(device["id"]).to_not eq(nil)

      device = TACore::Device.update(TOKEN, TEST_CLIENT_KEY, device["id"].to_s, {:venue_id => nil})
      expect(device["venue_id"]).to eq(nil)

      destroy = TACore::Device.destroy(TOKEN, TEST_CLIENT_KEY, device["id"].to_s)
      expect(destroy).to_not eq(false)
    end
  end

end
