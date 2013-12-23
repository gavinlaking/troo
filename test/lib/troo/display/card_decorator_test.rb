require_relative "../../../test_helper"

module Troo
  describe CardDecorator do
    let(:described_class) { CardDecorator }
    let(:current)     { true }
    let(:description) { "Finish Troo for fame and fortune." }
    let(:options) { {} }

    before do
      @board   = Fabricate(:board)
      @list    = Fabricate(:list)
      @card    = Fabricate(:card, desc: description, current: current)
      @comment = Fabricate(:comment)
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
      subject { described_class.new(@card).short }

      it "returns a one line overview of the card" do
        subject.must_equal(" * (67) \e[0mMy Test Card\e[0m\n")
      end
    end

    describe "#name_str" do
      subject { described_class.new(@card).name_str }

      it "returns the formatted card name" do
        subject.must_equal("My Test Card\e[0m")
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
        subject.must_equal("(67) \e[0m")
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

      context "when there are comments" do
        it "returns the comments" do
          subject.must_equal("There are some comments.")
        end
      end

      context "when there are no comments" do
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

      context "when there are members" do
        before do
          @card.stubs(:members).returns([:member, :member])
        end

        it "returns the members" do
          subject.must_equal("There are some members.")
        end
      end

      context "when there are no members" do
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
        subject.must_match "\e[34m\e[4m(1) \e[0m\e[34m\e[4mMy Test Board\e[0m"
      end
    end

    describe "#list" do
      subject { described_class.new(@card).list }

      it "returns the list details" do
        subject.must_match "\e[32m\e[4m(1) \e[0m\e[32m\e[4mMy Test List\e[0m"
      end
    end
  end
end
