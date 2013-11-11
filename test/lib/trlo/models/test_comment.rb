require_relative "../../../test_helper"

module Trlo
  describe Comment do
    let(:comment) { OpenStruct.new(id:                "some_24bit_comment_id",
                                   member_creator_id: "some_24bit_member_id",
                                   date:              "11-11-2013 - 20:14",
                                   data: {
                                     "text" => "This is a test comment"
                                   }) }
    describe "#decorate" do
      subject { Comment.decorate(comment) }

      it "returns a hash containing data from the comment" do
        subject.must_equal({ member: "some_24bit_member_id",
                             text:   "This is a test comment",
                             date:   "11-11-2013 - 20:14" })
      end
    end

    describe "#member" do
      subject { Comment.new(comment).member }

      it "returns the name of the member whom posted the comment" do
        subject.must_equal "some_24bit_member_id"
      end
    end

    describe "#text" do
      subject { Comment.new(comment).text }

      it "returns the comment body" do
        subject.must_equal "This is a test comment"
      end
    end

    describe "#date" do
      subject { Comment.new(comment).date }

      it "returns the date and time the comment was posted" do
        subject.must_equal "11-11-2013 - 20:14"
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

