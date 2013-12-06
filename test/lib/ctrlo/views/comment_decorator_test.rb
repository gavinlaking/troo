require_relative "../../../test_helper"

module Ctrlo
  describe CommentDecorator do
    let(:described_class) { CommentDecorator }
    let(:comment) { Ctrlo::Comment.new({ text:   "Some comment text",
                                         date:   "" }) }

    describe "#initialize" do
      subject { described_class.new(comment) }

      it "assigns the comment" do
        subject.instance_variable_get("@comment").must_equal comment
      end
    end

    describe "#as_view" do
    end

    describe "#member_username" do
      subject { described_class.new(comment).member_username }

      before do
        comment.member = member
      end

      describe "when the member username is known" do
        let(:member) { Ctrlo::Member.new({ username: "gavinlaking1" }) }

        it "returns the username" do
          subject.must_equal "gavinlaking1"
        end
      end

      describe "when the member username is not known" do
        let(:member) { Ctrlo::Member.new() }

        it "returns unknown" do
          subject.must_equal "Unknown"
        end
      end
    end

    describe "#text" do
      subject { described_class.new(comment).text }
    end

    describe "#date" do
      subject { described_class.new(comment).date }
    end

    describe "#template_file" do
      subject { described_class.new(comment).template_file }

      it "returns the template file to be used" do
        subject.must_equal "/comment_decorator.erb"
      end
    end
  end
end
