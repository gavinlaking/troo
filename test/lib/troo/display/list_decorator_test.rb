require_relative "../../../test_helper"

module Troo
  describe ListDecorator do
    let(:described_class) { ListDecorator }
    let(:current) { true }

    before do
      Ohm.redis.flushall
      @list = Troo::List.create({
        name:             "My Test List",
        current:          current,
        closed:           false,
        external_list_id: "526d8e130a14a9d846001d97"
      })
    end

    after do
      @list.delete
    end

    describe "#initialize" do
      subject { described_class.new(@list) }

      it "assigns the list to an instance variable" do
        subject.instance_variable_get("@list").must_equal(@list)
      end
    end

    describe "#short" do
      subject { described_class.new(@list).short }

      it "returns a one line overview of the list" do
        subject.must_equal(" *     (1) My Test List\n")
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
        subject.must_equal("(#{@list.id})")
      end
    end
  end
end
