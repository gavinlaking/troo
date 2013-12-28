require_relative "../../../test_helper"

module Troo
  describe CommentPresenter do
    let(:described_class) { CommentPresenter }
    let(:options) { { } }

    before do
      @card = Fabricate(:card)
      @comment = Fabricate(:comment)
      @member = Fabricate(:member)
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

    describe "#render_show" do
      subject { capture_io { described_class.render_show(@card, options) }.join }

      context "when the card has comments" do
        it "renders the view" do
          subject.must_match /My Test Card/
          subject.must_match /My Test Comment/
        end
      end

      context "when the card has no comments" do
        before do
          @comment.delete
        end

        it "returns a polite message" do
          subject.must_match /No comments were found/
        end
      end


    end
  end
end
