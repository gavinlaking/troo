require_relative "../../../test_helper"

module Troo
  describe CardPresenter do
    let(:described_class) { CardPresenter }
    let(:options) { { } }

    before do
      @card  = Fabricate(:card)
      @board = Fabricate(:board)
      @list  = Fabricate(:list)
    end

    after { database_cleanup }

    describe "#initialize" do
      subject { described_class.new(@card, options) }

      it "assigns the card to an instance variable" do
        subject.instance_variable_get("@card").must_equal(@card)
      end

      it "assigns the options to an instance variable" do
        subject.instance_variable_get("@options").must_equal(options)
      end
    end

    describe "#show" do
      subject { capture_io { described_class.show(@card, options) }.join }

      it "renders the view" do
        subject.must_match /My Test Card/
        subject.must_match /No comments have been left/
        subject.must_match /Metadata/
      end
    end
  end
end
