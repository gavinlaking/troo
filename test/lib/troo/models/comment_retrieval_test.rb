require_relative "../../../test_helper"

module Troo
  describe CommentRetrieval do
    let(:described_class) { CommentRetrieval }

    before do
      @comment = Fabricate(:comment)
    end

    after do
      database_cleanup
    end

    describe ".retrieve" do
      context "without an ID" do
        subject { described_class.retrieve }

        it "retrieves all locally stored comments" do
          subject.size.must_equal 1
        end
      end

      context "with an ID" do
        subject { described_class.retrieve(id) }

        context "local retrieval by database ID" do
          let(:id) { @comment.id }

          it "returns the correct comment" do
            subject.text.must_equal("My Test Comment")
          end
        end

        context "local retrieval by external ID" do
          let(:id) { "51f9277b2822b8654f0023af" }

          it "returns the correct comment" do
            subject.text.must_equal("My Test Comment")
          end
        end
      end
    end
  end
end
