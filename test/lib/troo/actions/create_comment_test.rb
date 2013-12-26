require_relative "../../../test_helper"

module Troo
  describe CreateComment do
    let(:described_class) { CreateComment }
    let(:card_id) { "526d8f19ddb279532e005259" }
    let(:comment) { "Some much needed feedback..." }

    before do
      @card = Fabricate(:card)
      Troo::CardRetrieval.stubs(:retrieve).returns(@card)
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

    describe "#create" do
      before { VCR.insert_cassette(:create_comment, decode_compressed_response: true) }
      after  { VCR.eject_cassette }

      subject { described_class.for(card_id, comment) }

      context "when the comment text is provided" do
        it "creates the comment and returns an instance of this class" do
          subject.must_be_instance_of(described_class)
        end
      end

      context "when the comment text is not provided" do
        let(:comment) { nil }
        let(:user_input_comment) { "Some much needed feedback..." }

        before do
          Input.stubs(:get).returns(user_input_comment)
        end

        it "asks the user to enter their text and creates the comment" do
          subject.must_be_instance_of(described_class)
        end
      end
    end

    context "it exposes various attributes we will use later" do
      subject { described_class.new(card_id, comment) }

      describe "#external_card_id" do
        it "returns the external_card_id" do
          subject.external_card_id.must_equal(@card.external_card_id)
        end
      end
    end
  end
end
