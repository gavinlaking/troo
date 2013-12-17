require_relative "../../../test_helper"
require "date"

module Troo
  describe CardDecorator do
    let(:described_class) { CardDecorator }

    let(:current)     { true }
    let(:description) { "Finish Troo for fame and fortune." }

    before do
      Ohm.redis.flushall
      @card = Troo::Card.create({
        short_id:           "67",
        name:               "My Test Card",
        desc:               description,
        last_activity_date: DateTime.civil(2013, 12, 17, 21, 48, 9),
        current:            current,
        closed:             false,
        external_card_id:   "526d8f19ddb279532e005259"
      })
      @comment = Troo::Comment.create({
        text: "Just fortune will suffice.",
        external_card_id: "526d8f19ddb279532e005259"
      })
    end

    after do
      @card.delete
      @comment.delete
    end

    describe "#initialize" do
      subject { described_class.new(@card) }

      it "assigns the card to an instance variable" do
        subject.instance_variable_get("@card").must_equal(@card)
      end
    end

    describe "#name" do
      subject { described_class.new(@card).name }

      it "returns the card name" do
        subject.must_equal(@card.name)
      end
    end

    describe "#description" do
      subject { described_class.new(@card).description }

      describe "when there are further details" do
        it "returns the description" do
          subject.must_equal(@card.desc)
        end
      end

      describe "when there are no further details" do
        let(:description) { nil }

        it "returns a polite message" do
          subject.must_equal("There are no further details at this time.")
        end
      end
    end

    describe "#comments" do
      subject { described_class.new(@card).comments }

      describe "when there are comments" do
        it "returns the comments" do
          subject.must_equal("There are some comments.")
        end
      end

      describe "when there are no comments" do
        before do
          @comment.delete
        end

        it "returns a polite message" do
          subject.must_equal("No comments have been left.")
        end
      end
    end

    describe "#members" do
      subject { described_class.new(@card).members }

      describe "when there are members" do
        before do
          @card.stubs(:members).returns([:member, :member])
        end

        it "returns the members" do
          subject.must_equal("There are some members.")
        end
      end

      describe "when there are no members" do
        it "returns a polite message" do
          subject.must_equal("No members have been assigned.")
        end
      end
    end

    describe "#last_activity_date" do
      subject { described_class.new(@card).last_activity_date }

      it "returns the last activity date" do
        subject.must_equal("Tue, Dec 17 at 21:48")
      end
    end

    describe "#current" do
      subject { described_class.new(@card).current }

      describe "when current" do
        it "return an indicator" do
          subject.must_equal("*")
        end
      end

      describe "when not current" do
        let(:current) { false }

        it "returns nothing" do
          subject.must_equal("")
        end
      end
    end

    describe "#id" do
      subject { described_class.new(@card).id }

      it "returns the card id" do
        subject.must_equal("(#{@card.short_id})")
      end
    end
  end
end
