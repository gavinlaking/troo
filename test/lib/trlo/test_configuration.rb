require_relative "../../test_helper.rb"

module Trlo
  describe Configuration do
    before do
      Configuration.load!(File.dirname(__FILE__) + "/../../../configuration.yml.example")
    end

    it "configures the key" do
      Configuration.instance.key.must_equal "some_key"
    end

    it "configures the secret" do
      Configuration.instance.secret.must_equal "some_secret"
    end
  end
end
