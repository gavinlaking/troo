require_relative "../../../test_helper"

module Trlo
  describe Comment do
    describe "#decorate" do
      subject { Comment.decorate(comment) }

      it "" do
        skip("Please write spec.")
      end
    end

    describe "#member" do
      subject { Comment.decorate(comment).member }

      it "" do
        skip("Please write spec.")
      end
    end

    describe "#text" do
      subject { Comment.decorate(comment).text }

      it "" do
        skip("Please write spec.")
      end
    end

    describe "#date" do
      subject { Comment.decorate(comment).date }

      it "" do
        skip("Please write spec.")
      end
    end
  end

  describe FindComment do
    describe ".with" do
      let(:comment_id) { "some_24bit_comment_id" }

      subject { FindComment.with(comment_id) }

      it "finds the comment by comment_id" do
        skip("Please write spec.")
      end
    end
  end

  describe FindComments do
    describe "#all_comments" do
      let(:card_id) { "some_24bit_card_id" }

      subject { FindComment.for(card_id) }

      it "finds all the comments by card_id" do
        skip("Please write spec.")
      end
    end
  end

  describe CreateComment do
    describe "#create" do
      let(:card_id) { "some_24bit_card_id" }

      subject { CreateComment.for(card_id, comment) }

      describe "when a comment is supplied" do
        let(:comment) { }

        it "creates a comment on the specified card" do
          skip("Please write spec.")
        end
      end

      describe "when a comment is not supplied" do
        let(:comment) { }
        
        it "asks the user to provide a comment" do
          skip("Please write spec.")
        end

        it "creates a comment on the specified card" do
          skip("Please write spec.")
        end
      end
    end
  end
end

