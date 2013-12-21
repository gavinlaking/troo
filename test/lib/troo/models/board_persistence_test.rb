require_relative "../../../test_helper"

module Troo
  describe BoardPersistence do
    let(:described_class) { BoardPersistence }
    let(:resource) { OpenStruct.new({
      id:     "526d8e130a14a9d846001d96",
      name:   resource_name,
      closed: false
    }) }

    before do
      @board = Fabricate(:board)
    end

    after do
      database_cleanup
    end

    describe "#persist" do
      subject { described_class.for(resource) }

      context "when an identical copy already exists locally" do
        let(:resource_name) { "My Test Board" }

        it "returns the local copy" do
          subject.must_equal(@board)
        end
      end

      context "when the local copy is out of date" do
        let(:resource_name) { "My Renamed Board" }

        it "updates and returns the new local copy" do
          subject.name.must_equal("My Renamed Board")
        end
      end

      context "when there is no local copy" do
        let(:resource_name) { "My New Test Board" }

        before do
          database_cleanup
        end

        it "creates and returns the new local copy" do
          subject.name.must_equal("My New Test Board")
        end
      end
    end
  end
end

