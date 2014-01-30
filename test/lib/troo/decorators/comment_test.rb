require_relative "../../../test_helper"

module Troo
  module Decorators
    describe Comment do
      let(:described_class) { Comment }
      let(:default) { true }
      let(:options) { {} }

      before do
        @comment = Fabricate(:comment)
        @member  = Fabricate(:member)
      end

      after { database_cleanup }

      describe "#initialize" do
        subject { described_class.new(@comment, options) }

        it "assigns the comment to an instance variable" do
          subject.instance_variable_get("@comment").must_equal(@comment)
        end

        it "assigns the options to an instance variable" do
          subject.instance_variable_get("@options").must_equal(options)
        end
      end

      describe "#as_view" do
        subject { described_class.new(@comment).as_view }

        it "returns the rendered comment" do
          subject.must_match /gavinlaking1/
          subject.must_match /My Test Comment/
          subject.must_match /Tue, Dec 17 at 22:01/
        end
      end

      describe "#member_username" do
        subject { described_class.new(@comment).member_username }

        it "returns the comment member username" do
          subject.must_equal(@comment.member.username + ":")
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
end
