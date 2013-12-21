require_relative "../../../test_helper"

module Troo
  describe CommentPersistence do
    let(:described_class) { CommentPersistence }
    let(:resource) { OpenStruct.new({
      id:   "51f9277b2822b8654f0023af",
      date: DateTime.civil(2013, 12, 17, 22, 1, 13),
      data: {
        "text" => resource_text, "board" => {
          "id" => "526d8e130a14a9d846001d96"
        }, "card" => {
          "id" => "526d8f19ddb279532e005259"
        } }
    }) }

    before do
      @comment = Fabricate(:comment)
    end

    after do
      database_cleanup
    end

    describe "#persist" do
      subject { described_class.for(resource) }

      context "when an identical copy already exists locally" do
        let(:resource_text) { "My Test Comment" }

        it "returns the local copy" do
          subject.must_equal(@comment)
        end
      end

      context "when the local copy is out of date" do
        let(:resource_text) { "My Renamed Comment" }

        it "updates and returns the new local copy" do
          subject.text.must_equal("My Renamed Comment")
        end
      end

      context "when there is no local copy" do
        let(:resource_text) { "My New Test Comment" }

        before do
          database_cleanup
        end

        it "creates and returns the new local copy" do
          subject.text.must_equal("My New Test Comment")
        end
      end
    end
  end
end

