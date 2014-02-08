require_relative "../../../test_helper"

module Troo
  describe Sentence do
    let(:described_class) { Sentence }
    let(:elements)        { ["Hydrogen"] }
    let(:label)           { "elements" }

    describe "#initialize" do
      subject { described_class.new(elements, label) }

      it "assigns the elements to an instance variable" do
        subject.instance_variable_get("@elements").must_equal(elements)
      end

      it "assigns the label to an instance variable" do
        subject.instance_variable_get("@label").must_equal(label)
      end
    end

    describe ".construct" do
      subject { described_class.construct(elements, label) }

      context "when there is one element" do
        let(:elements) { ["Hydrogen"] }

        it "returns the element as a string" do
          subject.must_equal("Hydrogen")
        end
      end

      context "when there are two elements" do
        let(:elements) { ["Hydrogen", "Helium"] }

        it "returns the elements joined with 'and'" do
          subject.must_equal("Hydrogen and Helium")
        end
      end

      context "when there are more than two elements" do
        let(:elements) { ["Hydrogen", "Helium", "Lithium"] }

        it "returns the elements as a sentence list" do
          subject.must_equal("Hydrogen, Helium and Lithium")
        end
      end

      context "when there are no elements" do
        let(:elements) { [] }

        it "returns a polite message" do
          subject.must_equal("No elements have been assigned.")
        end
      end
    end
  end
end
