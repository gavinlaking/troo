require_relative "../../../test_helper"

module Troo
  describe CardPresenter do
    let(:described_class) { CardPresenter }
    let(:options) { { } }

    before do
      @card = Fabricate(:card)
    end

    after do
      database_cleanup
    end

    describe "#initialize" do
      subject { described_class.new(@card, options) }

      it "assigns the card to an instance variable" do
        subject.instance_variable_get("@card").must_equal(@card)
      end

      it "assigns the options to an instance variable" do
        subject.instance_variable_get("@options").must_equal(options)
      end
    end
  end
end
