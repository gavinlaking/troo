require_relative "../../../test_helper"

class ModelHelpersDummy < Ohm::Model
  include Troo::ModelHelpers

  attribute :name
  attribute :default

  index     :name
  index     :default
end

module Troo
  describe ModelHelpersDummy do
    let(:described_class) { ModelHelpersDummy }

    before do
      @dumb   = ModelHelpersDummy.create({
                 name: "My Dumb Model",
                 default: false })
      @dumber = ModelHelpersDummy.create({
                 name: "My Dumber Model",
                 default: true })
    end

    after { database_cleanup }

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

    describe ".default" do
      subject { described_class.default }

      context "when there is no default model" do
        it "returns the model" do
          subject.must_equal(@dumber)
        end
      end

      context "when there is a default model" do
        before do
          @dumber.delete
        end

        it "returns nil" do
          subject.must_equal(nil)
        end
      end
    end

    describe ".count" do
      subject { described_class.count }

      it "returns the number of this model persisted" do
        subject.must_equal(2)
      end
    end

    describe "#external_attributes" do
      subject { @dumb.external_attributes }

      it "returns the attributes of the model which Trello affects" do
        subject.must_equal({ name: "My Dumb Model" })
      end
    end
  end
end
