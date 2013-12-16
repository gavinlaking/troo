require_relative "../../../test_helper"

module Troo
  describe BoardRetrieval do
    let(:described_class) { BoardRetrieval }

    before do
      Ohm.redis.flushall
    end

    describe ".current" do
      subject { described_class.current }

      before do
        @current = Troo::Board.create(current: current)
      end

      after do
        @current.delete
      end

      describe "when current is set" do
        let(:current) { true }

        it "returns the current" do
          subject.must_equal @current
        end
      end

      describe "when current is not set" do
        let(:current) { false }

        it "returns nil" do
          subject.must_equal nil
        end
      end
    end

    describe ".retrieve" do
      before do
        @board = Troo::Board.create({
                  name:              "My Test Board",
                  external_board_id: "526d8e130a14a9d846001d96" })
      end

      after do
        @board.delete
      end

      describe "without an ID" do
        subject { described_class.retrieve }

        it "retrieves all locally stored boards" do
          subject.size.must_equal 1
        end
      end

      describe "with an ID" do
        subject { described_class.retrieve(id) }

        describe "local retrieval by database ID" do
          let(:id) { @board.id }

          it "returns the correct board" do
            subject.name.must_equal("My Test Board")
          end
        end

        describe "local retrieval by external ID" do
          let(:id) { "526d8e130a14a9d846001d96" }

          it "returns the correct board" do
            subject.name.must_equal("My Test Board")
          end
        end

        describe "remote retrieval by either ID" do
          before do
            @board.delete
            ExternalBoard.stubs(:fetch).returns(remote_board)
          end

          let(:id) { "526d_remote_board_005259" }
          let(:remote_board) { [Troo::Board.new({
                                 name:              "My Remote Test Board",
                                 external_board_id: id })] }

          it "returns the correct board" do
            subject.name.must_equal("My Remote Test Board")
          end
        end
      end
    end
  end
end
