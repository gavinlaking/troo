require_relative "../../../test_helper"

module Troo
  describe MoveCard do
    let(:described_class) { MoveCard }
    let(:card_id) { }
    let(:list_id) { }

    describe ".initialize" do
      subject { described_class.new(card_id, list_id) }

      it "assigns the card_id" do
        subject.instance_variable_get("@card_id").must_equal(card_id)
      end

      it "assigns the list_id" do
        subject.instance_variable_get("@list_id").must_equal(list_id)
      end
    end

    describe "#move" do
      subject { described_class.with(card_id, list_id) }

      it "" do
        skip
      end
    end

    describe "#source_list_id" do
      subject { }

      it "" do
        skip
      end
    end

    describe "#destination_list_id" do
      subject { }

      it "" do
        skip
      end
    end
  end
end
