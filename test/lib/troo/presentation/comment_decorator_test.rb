require_relative "../../../test_helper"

module Troo
  describe CommentDecorator do
    let(:described_class) { CommentDecorator }
    let(:comment) { Troo::Comment.new({ text:   "Some comment text",
                                         date:   "" }) }

    describe "#initialize" do
      subject { described_class.new(comment) }

      it "assigns the comment" do
        subject.instance_variable_get("@comment").must_equal comment
      end
    end

    describe "#as_view" do
      it "" do
        skip
      end
    end

    describe "#member_username" do
      subject { described_class.new(comment).member_username }

      before do
        comment.member = member
      end

      describe "when the member username is known" do
        let(:member) { Troo::Member.new({ username: "gavinlaking1" }) }

        it "returns the username" do
          subject.must_equal "gavinlaking1"
        end
      end

      describe "when the member username is not known" do
        let(:member) { Troo::Member.new() }

        it "returns unknown" do
          subject.must_equal "Unknown"
        end
      end
    end

    describe "#text" do
      subject { described_class.new(comment).text }

      it "" do
        skip
      end
    end

    describe "#date" do
      subject { described_class.new(comment).date }

      it "" do
        skip
      end
    end
  end
end
