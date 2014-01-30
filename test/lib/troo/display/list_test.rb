require_relative "../../../test_helper"

module Troo
  describe ListPresenter do
    let(:described_class) { ListPresenter }
    let(:options) { { } }

    before do
      @list = Fabricate(:list)
      @board = Fabricate(:board)
      @card = Fabricate(:card)
    end

    after { database_cleanup }

    describe "#initialize" do
      subject { described_class.new(@list, options) }

      it "assigns the list to an instance variable" do
        subject.instance_variable_get("@list").must_equal(@list)
      end

      it "assigns the options to an instance variable" do
        subject.instance_variable_get("@options").must_equal(options)
      end
    end

    describe "#show" do
      subject { capture_io { described_class.show(@list, options) }.join }

      context "when the list has cards" do
        it "renders the view" do
          subject.must_match /My Test Board/
          subject.must_match /My Test List/
          subject.must_match /My Test Card/
        end
      end

      context "when the list has no cards" do
        before { @card.delete }

        it "returns a polite message" do
          subject.must_match /No cards were found./
        end
      end
    end
  end
end
