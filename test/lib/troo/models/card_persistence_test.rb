require_relative "../../../test_helper"

module Troo
  describe CardPersistence do
    let(:described_class) { CardPersistence }
    let(:resource) { OpenStruct.new({
      id:     "526d8f19ddb279532e005259",
      name:   resource_name,
      closed: false
    }) }

    before do
      @card = Fabricate(:card)
    end

    after do
      database_cleanup
    end

    describe "#persist" do
      subject { described_class.for(resource) }

      context "when an identical copy already exists locally" do
        let(:resource_name) { "My Test Card" }

        it "returns the local copy" do
          subject.must_equal(@card)
        end
      end

      context "when the local copy is out of date" do
        let(:resource_name) { "My Renamed Card" }

        it "updates and returns the new local copy" do
          subject.name.must_equal("My Renamed Card")
        end
      end

      context "when there is no local copy" do
        let(:resource_name) { "My New Test Card" }

        before do
          database_cleanup
        end

        it "creates and returns the new local copy" do
          subject.name.must_equal("My New Test Card")
        end
      end
    end
  end
end

