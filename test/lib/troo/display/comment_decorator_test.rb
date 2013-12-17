require_relative "../../../test_helper"
require "date"

module Troo
  describe CommentDecorator do
    let(:described_class) { CommentDecorator }
    let(:current) { true }

    before do
      Ohm.redis.flushall
      @comment = Troo::Comment.create({
        text:                "My Test Comment",
        date:                DateTime.civil(2013, 12, 17, 22, 1, 13),
        external_comment_id: "51f9277b2822b8654f0023af"
      })
    end

    after do
      @comment.delete
    end

    describe "#initialize" do
      subject { described_class.new(@comment) }

      it "assigns the comment to an instance variable" do
        subject.instance_variable_get("@comment").must_equal(@comment)
      end
    end

    describe "#text" do
      subject { described_class.new(@comment).text }

      it "returns the comment text" do
        subject.must_equal(@comment.text)
      end
    end

    describe "#date" do
      subject { described_class.new(@comment).date }

      it "returns the comment date" do
        subject.must_equal("Tue, Dec 17 at 22:01")
      end
    end

    describe "#id" do
      subject { described_class.new(@comment).id }

      it "returns the comment id" do
        subject.must_equal("(#{@comment.id})")
      end
    end
  end
end
