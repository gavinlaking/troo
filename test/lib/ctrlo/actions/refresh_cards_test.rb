require_relative "../../../test_helper"

module Ctrlo
  describe RefreshCards do
    let(:described_class) { RefreshCards }

    describe ".initialize" do
      let(:external_id) { "526d8f19ddb279532e005259" }
      let(:options)     { {} }

      subject { described_class.new(external_id, options) }

      it "assigns the external_id" do
        subject.instance_variable_get("@external_id").must_equal(external_id)
      end

      it "assigns the options" do
        subject.instance_variable_get("@options").must_equal({})
      end
    end

    describe "#refresh" do
    end
  end
end
