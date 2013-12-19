require_relative "../../../test_helper"

module Troo
  describe CommentPersistence do
    let(:described_class) { CommentPersistence }

    before do
      database_cleanup
      @comment = Troo::Comment.create({
        text:                "My Test Comment",
        external_comment_id: "526d8e130a14a9d846001d96"
      })
    end

    after do
      @comment.delete
    end

    describe "#persist" do
      subject { described_class.for(resource) }

      context "when an identical copy already exists locally" do
        let(:resource) { OpenStruct.new({
          id:   "526d8e130a14a9d846001d96",
          data: { "text" => "My Test Comment", "board" => { "id" => "" }, "card" => { "id" => "" } }
        }) }

        it "returns the local copy" do
          subject.must_equal(@comment)
        end
      end

      context "when the local copy is out of date" do
        let(:resource) { OpenStruct.new({
          id:   "526d8e130a14a9d846001d96",
          data: { "text" => "My Renamed Comment", "board" => { "id" => "" }, "card" => { "id" => "" } }
        }) }

        it "updates and returns the new local copy" do
          subject.text.must_equal("My Renamed Comment")
        end
      end

      context "when there is no local copy" do
        before do
          @comment.delete
        end

        let(:resource) { OpenStruct.new({
          id:   "526d8e130a14a9d846001d96",
          data: { "text" => "My New Test Comment", "board" => { "id" => "" }, "card" => { "id" => "" } }
        }) }

        it "creates and returns the new local copy" do
          subject.text.must_equal("My New Test Comment")
        end
      end
    end
  end
end

