require_relative "../../../test_helper"

module Troo
  describe CardDecorator do
    let(:described_class) { CardDecorator }
    let(:current)     { true }
    let(:description) { "Finish Troo for fame and fortune." }
    let(:options) { {} }

    before do
      @board     = Fabricate(:board)
      @list      = Fabricate(:list)
      @card      = Fabricate(:card, desc: description, current: current, external_member_ids: ["5195fdb5a8c01a2318004f5d", "some_member_id"])
      @comment   = Fabricate(:comment)
      @comment_2 = Fabricate(:comment, text: "My Other Test Comment")
      @comment_3 = Fabricate(:comment, text: "My Lithium Comment")
      @comment_4 = Fabricate(:comment, text: "My Beryllium Comment")
      @member    = Fabricate(:member)
      @member_2  = Fabricate(:member, username: "mysterywoman", external_member_id: "some_member_id")
    end

    after do
      database_cleanup
    end

    describe "#initialize" do
      subject { described_class.new(@card, options) }

      it "assigns the card to an instance variable" do
        subject.instance_variable_get("@card").must_equal(@card)
      end

      it "assigns the options to an instance variable" do
        subject.instance_variable_get("@options").must_equal(options)
      end
    end

    describe "#short" do
      subject { described_class.new(@card, options).short }

      it "returns a one line overview of the card" do
        subject.must_equal(" *  (67) My Test Card\n")
      end

      context "when the ansicolor option is false" do
        let(:options) { { ansicolor: false } }

        it "returns a one line overview of the board" do
          subject.must_equal(" *  (67) My Test Card\n")
        end
      end
    end

    describe "#name_str" do
      subject { described_class.new(@card).name_str }

      it "returns the formatted card name" do
        subject.must_equal("My Test Card")
      end
    end

    describe "#current_str" do
      subject { described_class.new(@card).current_str }

      it "returns the formatted card current indicator" do
        subject.must_equal(" * ")
      end
    end

    describe "#id_str" do
      subject { described_class.new(@card).id_str }

      it "returns the formatted card id" do
        subject.must_equal(" (67) ")
      end
    end

    describe "#name" do
      subject { described_class.new(@card).name }

      it "returns the card name" do
        subject.must_equal(@card.name)
      end
    end

    describe "#current" do
      subject { described_class.new(@card).current }

      context "when current" do
        it "return an indicator" do
          subject.must_equal("*")
        end
      end

      context "when not current" do
        let(:current) { false }

        it "returns nothing" do
          subject.must_equal("")
        end
      end
    end

    describe "#id" do
      subject { described_class.new(@card).id }

      it "returns the card id" do
        subject.must_equal(@card.short_id)
      end
    end

    describe "#description" do
      subject { described_class.new(@card).description }

      context "when there are further details" do
        it "returns the description" do
          subject.must_equal(@card.desc)
        end
      end

      context "when there are no further details" do
        let(:description) { nil }

        it "returns a polite message" do
          subject.must_equal("There are no further details at this time.")
        end
      end
    end

    describe "#comments" do
      subject { described_class.new(@card).comments }

      context "when there are more than 3 comments" do
        it "returns the comments" do
          subject.must_match /There are more comments/
          subject.must_match /My Test Comment/
          subject.must_match /My Other Test Comment/
          subject.must_match /My Lithium Comment/
          subject.wont_match /My Beryllium Comment/
        end
      end

      context "when there are 3 or less comments" do
        before do
          @comment_3.delete
          @comment_4.delete
        end

        it "returns the comments" do
          subject.must_match /My Test Comment/
          subject.must_match /My Other Test Comment/
        end
      end

      context "when there are no comments" do
        before do
          @comment.delete
          @comment_2.delete
          @comment_3.delete
          @comment_4.delete
        end

        it "returns a polite message" do
          subject.must_equal("No comments have been left.")
        end
      end
    end

    describe "#members" do
      subject { described_class.new(@card).members }

      context "when there are members" do
        it "returns the members" do
          subject.must_equal("@gavinlaking1 and @mysterywoman")
        end
      end

      context "when there are no members" do
        before do
          @member.delete
          @member_2.delete
        end

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

    describe "#board" do
      subject { described_class.new(@card).board }

      it "returns the board details" do
        subject.must_match "(1) My Test Board"
      end
    end

    describe "#list" do
      subject { described_class.new(@card).list }

      it "returns the list details" do
        subject.must_match "(1) My Test List"
      end
    end
  end
end
