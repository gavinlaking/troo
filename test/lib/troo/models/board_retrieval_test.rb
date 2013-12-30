require_relative "../../../test_helper"

module Troo
  describe BoardRetrieval do
    let(:described_class) { BoardRetrieval }
    let(:current) { true }
    let(:board_name) { "My Test Board" }

    before do
      @board = Fabricate(:board, current: current, name: board_name)
    end

    after do
      database_cleanup
    end

    describe ".all" do
      subject { described_class.all }

      it "retrieves all locally stored lists" do
        subject.size.must_equal 1
      end
    end

    describe ".current" do
      subject { described_class.current }

      context "when current is set" do
        it "returns the current" do
          subject.must_equal @board
        end
      end

      context "when current is not set" do
        let(:current) { false }

        it "returns nil" do
          subject.must_equal nil
        end
      end
    end

    describe ".retrieve" do
      context "without an ID" do
        subject { described_class.retrieve }

        context "when current is set" do
          it "returns the current" do
            subject.must_equal @board
          end
        end

        context "when current is not set" do
          let(:current) { false }

          it "returns nil" do
            subject.must_equal nil
          end
        end
      end

      context "with an ID" do
        subject { described_class.retrieve(id) }

        context "local retrieval by database ID" do
          let(:id) { @board.id }

          it "returns the correct board" do
            subject.name.must_equal("My Test Board")
          end
        end

        context "local retrieval by external ID" do
          let(:id) { "526d8e130a14a9d846001d96" }

          it "returns the correct board" do
            subject.name.must_equal("My Test Board")
          end
        end

        context "remote retrieval by either ID" do
          let(:id)         { "526d_remote_board_005259" }
          let(:board_name) { "My Remote Test Board" }

          before do
            ExternalBoard.stubs(:fetch).returns([@board])
          end

          it "returns the correct board" do
            subject.name.must_equal("My Remote Test Board")
          end
        end

        context "when the ID cannot be found" do
          let(:id) { "not_found_id" }

          before { ExternalBoard.stubs(:fetch).returns([]) }

          it "returns nil" do
            subject.must_equal nil
          end
        end
      end
    end
  end
end
