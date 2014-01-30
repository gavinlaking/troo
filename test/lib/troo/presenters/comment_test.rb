require_relative "../../../test_helper"

module Troo
  module Presenters
    describe Comment do
      let(:described_class) { Comment }
      let(:options) { { } }

      before do
        @card = Fabricate(:card)
        @comment = Fabricate(:comment)
        @member = Fabricate(:member)
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

        context "when the card has comments" do
          it "renders the view" do
            subject.must_match /My Test Card/
            subject.must_match /My Test Comment/
          end
        end

        context "when the card has no comments" do
          before { @comment.delete }

          it "returns a polite message" do
            subject.must_match /No comments were found/
          end
        end
      end
    end
  end
end
