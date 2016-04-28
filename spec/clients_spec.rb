require 'spec_helper'

describe TACore do

  context "Find Client" do
    it "should get a single client" do
      client = TACore::Client.create(TOKEN, {:name => "Test Script Test Company", :app_id => 0})
      client = TACore::Client.find(TOKEN, client["api_key"])
      expect(client["name"]).to eq("Test Script Test Company")

      client = TACore::Client.destroy(TOKEN, client["api_key"])
      expect(client["destroy"]).to_not eq(false)
    end

    it "will get all clients (Admin Only)" do
      clients = TACore::Client.all(TOKEN)
      expect(clients.count).to_not eq(0)
    end
  end

  context "Alter Client" do
    it "activate client" do
      new_client = TACore::Client.create(TOKEN, {:name => "Test Script Test Company", :app_id => 0})
      client = TACore::Client.activate(TOKEN, new_client["api_key"])
      expect(client["saved"]).to eq(true)

      client = TACore::Client.destroy(TOKEN, new_client["api_key"])
      expect(client["destroy"]).to_not eq(false)
    end

    it "rename client" do
      client = TACore::Client.create(TOKEN, {:name => "Test Script Test Company", :app_id => 0})
      client = TACore::Client.update(TOKEN, client["api_key"], {:name => "My New Name"})
      expect(client["name"]).to eq("My New Name")

      client = TACore::Client.destroy(TOKEN, client["api_key"])
      expect(client["destroy"]).to_not eq(false)
    end

    it "revert the rename" do
      client = TACore::Client.create(TOKEN, {:name => "Test Script Test Company", :app_id => 0})
      client = TACore::Client.update(TOKEN, client["api_key"], {:name => TEST_CLIENT_NAME})
      expect(client["name"]).to eq(TEST_CLIENT_NAME)

      client = TACore::Client.destroy(TOKEN, client["api_key"])
      expect(client["destroy"]).to_not eq(false)
    end
  end

  context "Create and Destroy Client" do
    it "create a new client then detroy it" do
      # => Create
      client = TACore::Client.create(TOKEN, {:name => "Test Script Test Company", :app_id => 0})
      expect(client["name"]).to eq("Test Script Test Company")
      expect(client["app_id"]).to eq(0)

      # => Destroy
      client = TACore::Client.destroy(TOKEN, client["api_key"])
      expect(client["destroy"]).to_not eq(false)
    end

  end

end
