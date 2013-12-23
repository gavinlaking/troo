require_relative "../../../test_helper"

module Troo
  describe ListPresenter do
    let(:described_class) { ListPresenter }
    let(:options) { { } }

    before do
      @list = Fabricate(:list)
      @board = Fabricate(:board)
    end

    after do
      database_cleanup
    end

    describe "#initialize" do
      subject { described_class.new(@list, options) }

      it "assigns the list to an instance variable" do
        subject.instance_variable_get("@list").must_equal(@list)
      end

      it "assigns the options to an instance variable" do
        subject.instance_variable_get("@options").must_equal(options)
      end
    end

    describe "#render_show" do
      subject { capture_io { described_class.new(@list, options).render_show }.join }

      context "when the list has cards" do
        it "does something" do
          skip
        end
      end

      context "when the list has no cards" do
        it "returns a polite message" do
          subject.must_match /No cards were found./
        end
      end
    end
  end
end
