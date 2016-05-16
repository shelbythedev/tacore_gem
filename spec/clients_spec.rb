require 'spec_helper'

describe TACore do

  context "Find Client" do
    it "should get a single client" do
      client = TACore::Client.create(TOKEN, {:name => "Test Script Test Company", :app_id => 0})
      client = TACore::Client.find(TOKEN, client["api_key"])
      expect(client["name"]).to eq("Test Script Test Company")

    end

    it "will get all clients" do
      clients = TACore::Client.all(TOKEN)
      expect(clients.count).to_not eq(0)
    end
  end

  context "Alter Client" do

    it "rename client" do
      client = TACore::Client.create(TOKEN, {:name => "Test Script Test Company", :app_id => 0})
      client = TACore::Client.update(TOKEN, client["api_key"], {:name => "My New Name"})
      expect(client["name"]).to eq("My New Name")

    end

    it "revert the rename" do
      client = TACore::Client.create(TOKEN, {:name => "Test Script Test Company", :app_id => 0})
      client = TACore::Client.update(TOKEN, client["api_key"], {:name => TEST_CLIENT_NAME})
      expect(client["name"]).to eq(TEST_CLIENT_NAME)

    end
  end


end
