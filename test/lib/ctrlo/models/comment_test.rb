require_relative "../../../test_helper"

module Ctrlo
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
end

