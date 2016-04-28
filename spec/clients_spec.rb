require 'spec_helper'

describe TACore do

  context "Find Client" do
    it "should get a single client" do
      client = TACore::Client.find(TOKEN, TEST_CLIENT_KEY)
      expect(client["name"]).to eq(TEST_CLIENT_NAME)
    end

    it "will get all clients (Admin Only)" do
      clients = TACore::Client.all(TOKEN)
      expect(clients.count).to_not eq(0)
    end
  end

  context "Alter Client" do
    it "activate client" do
      client = TACore::Client.activate(TOKEN, TEST_CLIENT_KEY)
      expect(client["saved"]).to eq(true)
    end

    it "rename client" do
      client = TACore::Client.update(TOKEN, TEST_CLIENT_KEY, {:name => "My New Name"})
      expect(client["name"]).to eq("My New Name")
    end

    it "revert the rename" do
      client = TACore::Client.update(TOKEN, TEST_CLIENT_KEY, {:name => TEST_CLIENT_NAME})
      expect(client["name"]).to eq(TEST_CLIENT_NAME)
    end
  end

  context "Create and Destroy Client" do
    it "create a new client then detroy it" do
      # => Create
      client = TACore::Client.create(TOKEN, {:name => "Test Script Test Company"})
      expect(client["name"]).to eq("Test Script Test Company")

      # => Destroy
      client = TACore::Client.destroy(TOKEN, client["api_key"])
      expect(client["destroy"]).to_not eq(false)
    end

  end

end
