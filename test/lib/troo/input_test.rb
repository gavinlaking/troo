require_relative "../../test_helper"

module Troo
  describe Input do
    let(:described_class) { Input }
    let(:id) { "526d8e130a14a9d846001d96" }

    subject { described_class.new(id) }

    it "assigns the id to an instance variable" do
      subject.instance_variable_get("@id").must_equal(id)
    end
  end
end

