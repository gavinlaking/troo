require_relative "../../../test_helper"

module Troo
  describe BoardDecorator do
    let(:described_class) { BoardDecorator }
    let(:current) { true }

    before do
      Ohm.redis.flushall
      @board = Troo::Board.create({
        name:              "My Test Board",
        current:           current,
        closed:            false,
        external_board_id: "526d8e130a14a9d846001d96"
      })
    end

    after do
      @board.delete
    end

    describe "#initialize" do
      subject { described_class.new(@board) }

      it "assigns the board to an instance variable" do
        subject.instance_variable_get("@board").must_equal(@board)
      end
    end

    describe "#short" do
      subject { described_class.new(@board).short }

      it "returns a one line overview of the board" do
        subject.must_equal(" *     (1) My Test Board\n")
      end
    end

    describe "#name" do
      subject { described_class.new(@board).name }

      it "returns the board name" do
        subject.must_equal(@board.name)
      end
    end

    describe "#current" do
      subject { described_class.new(@board).current }

      context "when current" do
        it "return an indicator" do
          subject.must_equal("*")
        end
      end

      context "when not current" do
        let(:current) { false }

        it "returns nothing" do
          subject.must_equal("")
        end
      end
    end

    describe "#id" do
      subject { described_class.new(@board).id }

      it "returns the board id" do
        subject.must_equal("(#{@board.id})")
      end
    end
  end
end
