require_relative "../../../test_helper"

module Ctrlo
  describe CommentDecorator do
    describe "#initialize" do
      it "assigns the comment" do
      end
    end

    describe "#decorate" do

    end

    describe "#member_username" do
      describe "when the member username is known" do
        it "returns the username" do
          subject.must_equal "gavinlaking1"
        end
      end

      describe "when the member username is not known" do
        it "returns unknown" do
          subject.must_equal "Unknown"
        end
      end
    end

    describe "#text" do

    end

    describe "#date" do

    end

    describe "#template_file" do
      it "returns the template file to be used" do
        subject.must_equal "/comment_decorator.erb"
      end
    end
  end
end
