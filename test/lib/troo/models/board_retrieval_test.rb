require_relative "../../../test_helper"

module Troo
  describe BoardRetrieval do
    let(:described_class) { BoardRetrieval }
    let(:default) { true }
    let(:board_name) { "My Test Board" }

    before { @board = Fabricate(:board, default: default, name: board_name) }
    after  { database_cleanup }

    describe ".all" do
      subject { described_class.all }

      it "retrieves all locally stored lists" do
        subject.size.must_equal 1
      end
    end

    describe ".default" do
      subject { described_class.default }

      context "when default is set" do
        it "returns the default" do
          subject.must_equal @board
        end
      end

      context "when default is not set" do
        let(:default) { false }

        it { subject.must_equal(nil) }
      end
    end

    describe ".retrieve" do
      context "without an ID" do
        subject { described_class.retrieve }

        context "when default is set" do
          it "returns the default" do
            subject.must_equal @board
          end
        end

        context "when default is not set" do
          let(:default) { false }

          it { subject.must_equal(nil) }
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

          before { External::Board.stubs(:fetch).returns([@board]) }

          it "returns the correct board" do
            subject.name.must_equal("My Remote Test Board")
          end
        end

        context "when the ID cannot be found" do
          let(:id) { "not_found_id" }

          before { External::Board.stubs(:fetch).returns([]) }

          it { subject.must_equal(nil) }
        end
      end
    end
  end
end
