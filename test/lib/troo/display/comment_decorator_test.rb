require_relative "../../../test_helper"

module Troo
  describe CommentDecorator do
    let(:described_class) { CommentDecorator }
    let(:current) { true }
    let(:options) { {} }

    before do
      @comment = Fabricate(:comment)
    end

    after do
      database_cleanup
    end

    describe "#initialize" do
      subject { described_class.new(@comment, options) }

      it "assigns the comment to an instance variable" do
        subject.instance_variable_get("@comment").must_equal(@comment)
      end

      it "assigns the options to an instance variable" do
        subject.instance_variable_get("@options").must_equal(options)
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
