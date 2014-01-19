require_relative "../../../test_helper"

module Troo
  describe BoardDecorator do
    let(:described_class) { BoardDecorator }
    let(:default) { true }
    let(:options) { {} }

    before { @board = Fabricate(:board, default: default) }
    after  { database_cleanup }

    describe "#initialize" do
      subject { described_class.new(@board, options) }

      it "assigns the board to an instance variable" do
        subject.instance_variable_get("@board").must_equal(@board)
      end

      it "assigns the options to an instance variable" do
        subject.instance_variable_get("@options").must_equal(options)
      end
    end

    describe "#short" do
      subject { described_class.new(@board, options).short }

      it "returns a one line overview of the board" do
        subject.must_equal(" * \e[34m\e[4m(1) \e[0m\e[34m\e[4mMy Test Board\e[0m\n")
      end

      context "when the ansicolor option is false" do
        let(:options) { { ansicolor: false } }

        it "returns a one line overview of the board" do
          subject.must_equal(" *   (1) My Test Board\n")
        end
      end
    end

    describe "#name_str" do
      subject { described_class.new(@board).name_str }

      it "returns the formatted board name" do
        subject.must_equal("\e[34m\e[4mMy Test Board\e[0m")
      end
    end

    describe "#default_str" do
      subject { described_class.new(@board).default_str }

      it "returns the formatted board default indicator" do
        subject.must_equal(" * ")
      end
    end

    describe "#id_str" do
      subject { described_class.new(@board).id_str }

      it "returns the formatted board id" do
        subject.must_equal("\e[34m\e[4m(1) \e[0m")
      end
    end

    describe "#description" do
      subject { described_class.new(@board).description }

      context "when the board has a description" do
        it "returns the board description" do
          subject.must_equal(@board.description)
        end
      end

      context "when the board has no description" do
        before { @board.stubs(:description) }

        it "returns N/A" do
          subject.must_equal("N/A")
        end
      end
    end

    describe "#name" do
      subject { described_class.new(@board).name }

      context "when the board has a name" do
        it "returns the board name" do
          subject.must_equal(@board.name)
        end
      end

      context "when the board has no name" do
        before { @board.stubs(:name) }

        it "returns N/A" do
          subject.must_equal("N/A")
        end
      end
    end

    describe "#default" do
      subject { described_class.new(@board).default }

      context "when default" do
        it "return an indicator" do
          subject.must_equal("*")
        end
      end

      context "when not default" do
        let(:default) { false }

        it "returns nothing" do
          subject.must_equal("")
        end
      end
    end

    describe "#id" do
      subject { described_class.new(@board).id }

      it "returns the board id" do
        subject.must_equal(@board.id.to_s)
      end
    end
  end
end
