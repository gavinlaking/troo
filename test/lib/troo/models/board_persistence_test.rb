require_relative "../../../test_helper"

module Troo
  describe BoardPersistence do
    let(:described_class) { BoardPersistence }

    before do
      Ohm.redis.flushall
      @board = Troo::Board.create({
        name:              "My Test Board",
        closed:            false,
        external_board_id: "526d8e130a14a9d846001d96"
      })
    end

    after do
      @board.delete
    end

    describe "#persist" do
      subject { described_class.for(resource) }

      describe "when an identical copy already exists locally" do
        let(:resource) { OpenStruct.new({
          id:     "526d8e130a14a9d846001d96",
          name:   "My Test Board",
          closed: false
        }) }

        it "returns the local copy" do
          subject.must_equal(@board)
        end
      end

      describe "when the local copy is out of date" do
        let(:resource) { OpenStruct.new({
          id:     "526d8e130a14a9d846001d96",
          name:   "My Renamed Board",
          closed: false
        }) }

        it "updates and returns the new local copy" do
          subject.name.must_equal("My Renamed Board")
        end
      end

      describe "when there is no local copy" do
        before do
          @board.delete
        end

        let(:resource) { OpenStruct.new({
          id:     "526d8e130a14a9d846001d96",
          name:   "My New Test Board",
          closed: false
        }) }

        it "creates and returns the new local copy" do
          subject.name.must_equal("My New Test Board")
        end
      end
    end
  end
end

