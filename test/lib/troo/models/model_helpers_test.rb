require_relative "../../../test_helper"

class ModelHelpersDummy < Ohm::Model
  include Troo::ModelHelpers

  attribute :name
  attribute :current

  index     :name
  index     :current
end

module Troo
  describe ModelHelpersDummy do
    let(:described_class) { ModelHelpersDummy }

    before do
      @dumb   = ModelHelpersDummy.create({
                 name: "My Dumb Model",
                 current: false })
      @dumber = ModelHelpersDummy.create({
                 name: "My Dumber Model",
                 current: true })
    end

    after do
      database_cleanup
    end

    describe ".first" do
      subject { described_class.first(criteria) }

      context "when no criteria are provided" do
        let(:criteria) { }

        it "returns the first model stored of that type" do
          subject.name.must_equal("My Dumb Model")
        end
      end

      context "when criteria are provided" do
        let(:criteria) { { name: "My Dumber Model" } }

        it "returns the first model matching the criteria" do
          subject.name.must_equal("My Dumber Model")
        end
      end
    end

    describe ".update" do
      subject { described_class.update(criteria) }

      context "when no criteria are provided" do
        let(:criteria) { }

        it "returns false; no update was performed" do
          subject.must_equal(false)
        end
      end

      context "when criteria are provided" do
        let(:criteria) { { name: "My Updated Model" } }

        it "updates all records with the criteria" do
          subject.must_equal(true)
          ModelHelpersDummy.all.each do |dummy|
            dummy.name.must_equal("My Updated Model")
          end
        end
      end
    end

    describe ".current" do
      subject { described_class.current }

      context "when there is no current model" do
        it "returns the model" do
          subject.must_equal(@dumber)
        end
      end

      context "when there is a current model" do
        before do
          @dumber.delete
        end

        it "returns nil" do
          subject.must_equal(nil)
        end
      end
    end

    context "#external_attributes" do
      subject { @dumb.external_attributes }

      it "returns the attributes of the model which Trello affects" do
        subject.must_equal({ name: "My Dumb Model" })
      end
    end
  end
end
