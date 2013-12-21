require_relative "../../../test_helper"

module Troo
  describe RefreshAll do
    let(:described_class) { RefreshAll }
    let(:options) { { } }

    describe ".initialize" do
      subject { described_class.new(options) }

      it "assigns the options" do
        subject.instance_variable_get("@options").must_equal(options)
      end
    end

    describe ".perform" do
      subject { described_class.perform(options) }

      it "fetches all the boards" do
        skip
      end

      it "fetches all the lists" do
        skip
      end

      it "fetches all the cards" do
        skip
      end

      it "fetches all the comments" do
        skip
      end

      it "fetches all the members" do
        skip
      end
    end
  end
end
