require 'spec_helper'

describe TACore do

  context "Create and Destroy an App" do
    it "create and destroy" do
      app = TACore::App.create(TOKEN, TEST_APP)
      expect(app["name"]).to eq(TEST_APP[:name])

      app = TACore::App.destroy(TOKEN, app["uid"])
      expect(app["destroy"]).to_not eq(false)
    end
  end

  context "Find App" do
    it "get app by UID" do
      app = TACore::App.create(TOKEN, TEST_APP)
      expect(app["name"]).to eq(TEST_APP[:name])

      app_data = TACore::App.find(TOKEN, app["uid"])
      expect(app_data["id"]).to eq(app["id"])

      app = TACore::App.destroy(TOKEN, app["uid"])
      expect(app["destroy"]).to_not eq(false)
    end
  end

  context "Alter App" do
    it "update the name" do
      app = TACore::App.create(TOKEN, TEST_APP)
      expect(app["name"]).to eq(TEST_APP[:name])

      app = TACore::App.update(TOKEN, app["uid"], {:name => "My new test name update"})
      expect(app["name"]).to_not eq(TEST_APP[:name])

      expect(TACore::App.destroy(TOKEN, app["uid"])).to_not eq(false)
    end
  end

end
