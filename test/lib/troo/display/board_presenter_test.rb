require_relative "../../../test_helper"

module Troo
  describe BoardPresenter do
    let(:described_class) { BoardPresenter }
    let(:options) { { } }

    before do
      @board = Fabricate(:board)
      @list  = Fabricate(:list)
      @card  = Fabricate(:card)
    end

    after { database_cleanup }

    describe "#initialize" do
      subject { described_class.new(@board, options) }

      it "assigns the board to an instance variable" do
        subject.instance_variable_get("@board").must_equal(@board)
      end

      it "assigns the options to an instance variable" do
        subject.instance_variable_get("@options").must_equal(options)
      end
    end

    describe "#all" do
      subject { capture_io { described_class.all([@board], options) }.join }

      context "when the board has lists" do
        it "renders the view" do
          subject.must_match /My Test Board/
          subject.must_match /My Test List/
        end
      end

      context "when the board has no lists" do
        before { @list.delete }

        it "returns a polite message" do
          subject.must_match /No lists were found./
        end
      end
    end

    describe "#show" do
      subject { capture_io { described_class.show(@board, options) }.join }

      context "when the board has lists" do
        context "and the list has cards" do
          it "renders the view" do
            subject.must_match /My Test Board/
            subject.must_match /My Test List/
            subject.must_match /My Test Card/
          end
        end

        context "and the list has no cards" do
          before { @card.delete }

          it "returns a polite message" do
            subject.must_match /No cards were found./
          end
        end
      end

      context "when the board has no lists" do
        before { @board.stubs(:lists).returns([]) }

        it "returns a polite message" do
          subject.must_match /No lists were found./
        end
      end
    end
  end
end
