require_relative "../../../test_helper"

module Ctrlo
  describe RefreshComments do
    let(:described_class) { RefreshComments }

    describe ".initialize" do
      let(:external_id) { "some_external_id" }
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
