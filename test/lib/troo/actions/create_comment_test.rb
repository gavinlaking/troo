require_relative "../../../test_helper"

module Troo
  describe CreateComment do
    let(:described_class) { CreateComment }
    let(:card_id) { "526d8f19ddb279532e005259" }
    let(:comment) { "Some much needed feedback..." }

    before do
      @card = Fabricate(:card)
      @comment = Fabricate(:comment, text: comment)
      Troo::CardRetrieval.stubs(:retrieve).returns(@card)
      Troo::CommentPersistence.stubs(:for).returns(@comment)
    end

    after do
      database_cleanup
    end

    describe ".initialize" do
      subject { described_class.new(card_id, comment) }

      it "assigns the card_id to an instance variable" do
        subject.instance_variable_get("@card_id").must_equal(card_id)
      end

      it "assigns the comment to an instance variable" do
        subject.instance_variable_get("@comment").must_equal(comment)
      end
    end

    describe ".for" do
      before { VCR.insert_cassette(:create_comment, decode_compressed_response: true) }
      after  { VCR.eject_cassette }

      subject { described_class.for(card_id, comment) }

      context "when the comment was created" do
        it "returns the new comment" do
          subject.must_equal(@comment)
        end
      end

      context "when the comment was not created" do
        before do
          Trello::Card.any_instance.stubs(:add_comment).raises(Trello::Error)
        end

        it "returns nil" do
          subject.must_equal false
        end
      end
    end
  end
end
