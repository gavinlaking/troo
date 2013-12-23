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

    after do
      database_cleanup
    end

    describe "#initialize" do
      subject { described_class.new(@board, options) }

      it "assigns the board to an instance variable" do
        subject.instance_variable_get("@board").must_equal(@board)
      end

      it "assigns the options to an instance variable" do
        subject.instance_variable_get("@options").must_equal(options)
      end
    end

    describe "#render_all" do
      subject { capture_io { described_class.new(@board, options).render_all }.join }

      context "when the board has lists" do
        it "does something" do
          skip
        end
      end

      context "when the board has no lists" do
        before do
          @list.delete
        end

        it "returns a polite message" do
          subject.must_match /No lists were found./
        end
      end
    end

    describe "#render_show" do
      subject { capture_io { described_class.new(@board, options).render_show }.join }

      context "when the board has lists" do
        context "when the list has cards" do
          it "does something" do
            skip
          end
        end

        context "when the list has no cards" do
          before do
            @card.delete
          end

          it "returns a polite message" do
            subject.must_match /No cards were found./
          end
        end
      end

      context "when the board has no lists" do
        before do
          @board.stubs(:lists).returns([])
        end

        it "returns a polite message" do
          subject.must_match /No lists were found./
        end
      end
    end
  end
end
