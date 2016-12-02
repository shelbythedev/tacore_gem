require 'spec_helper'

describe TACore do

  context "Authernticate" do
    it "gets a token back from the Auth server" do
      token = TACore::Auth.login["token"]
      expect(token).not_to eq(nil)
    end

  end

end
