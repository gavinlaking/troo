require_relative "../../../test_helper"

module Troo
  describe CreateComment do
    let(:described_class) { CreateComment }
    let(:card_id) { }
    let(:comment) { }

    before do
    end

    after do
      database_cleanup
    end

    describe ".initialize" do
      subject { described_class.new(card_id, comment) }

      it "assigns the card_id" do
        subject.instance_variable_get("@card_id").must_equal(card_id)
      end

      it "assigns the comment" do
        subject.instance_variable_get("@comment").must_equal(comment)
      end
    end

    describe "#create" do
      subject { described_class.for(card_id, comment) }

      it "" do
        skip
      end
    end
  end
end
