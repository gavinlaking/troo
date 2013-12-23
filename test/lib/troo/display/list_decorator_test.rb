require_relative "../../../test_helper"

module Troo
  describe ListDecorator do
    let(:described_class) { ListDecorator }
    let(:current) { true }
    let(:options) { {} }

    before do
      @list = Fabricate(:list, current: current)
    end

    after do
      database_cleanup
    end

    describe "#initialize" do
      subject { described_class.new(@list, options) }

      it "assigns the list to an instance variable" do
        subject.instance_variable_get("@list").must_equal(@list)
      end

      it "assigns the options to an instance variable" do
        subject.instance_variable_get("@options").must_equal(options)
      end
    end

    describe "#short" do
      subject { described_class.new(@list, options).short }

      it "returns a one line overview of the list" do
        subject.must_equal(" * \e[32m\e[4m(1) \e[0m\e[32m\e[4mMy Test List\e[0m\n")
      end

      context "when the ansicolor option is false" do
        let(:options) { { ansicolor: false } }

        it "returns a one line overview of the board" do
          subject.must_equal(" *   (1) My Test List\n")
        end
      end
    end

    describe "#name_str" do
      subject { described_class.new(@list).name_str }

      it "returns the formatted list name" do
        subject.must_equal("\e[32m\e[4mMy Test List\e[0m")
      end
    end

    describe "#current_str" do
      subject { described_class.new(@list).current_str }

      it "returns the formatted card current indicator" do
        subject.must_equal(" * ")
      end
    end

    describe "#id_str" do
      subject { described_class.new(@list).id_str }

      it "returns the formatted list id" do
        subject.must_equal("\e[32m\e[4m(1) \e[0m")
      end
    end

    describe "#name" do
      subject { described_class.new(@list).name }

      it "returns the list name" do
        subject.must_equal(@list.name)
      end
    end

    describe "#current" do
      subject { described_class.new(@list).current }

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
      subject { described_class.new(@list).id }

      it "returns the list id" do
        subject.must_equal(@list.id.to_s)
      end
    end
  end
end
