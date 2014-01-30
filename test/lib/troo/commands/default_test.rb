require_relative "../../../test_helper"
require "thor"

module Troo
  module CLI
    module Commands
      describe Default do
        let(:described_class) { Default }
        let(:type) { }
        let(:id) { }

        describe "#initialize" do
          subject { described_class.new(type, id) }

          it "assigns the type to an instance variable" do
            subject.instance_variable_get("@type").must_equal(type)
          end

          it "assigns the id to an instance variable" do
            subject.instance_variable_get("@id").must_equal(id)
          end
        end

        describe ".dispatch" do
          subject { described_class.dispatch(type, id) }

          context "when the board can be found" do

            it "sets the default and returns a polite message" do
              skip
            end
          end

          context "when the resource cannot be found" do
            context "and the resource is a board" do
              it "returns a polite message" do
                subject.must_equal("Board cannot be found.")
              end
            end

            context "and the resource is a list" do
              it "returns a polite message" do
                subject.must_equal("List cannot be found.")
              end
            end

            context "and the resource is a card" do
              it "returns a polite message" do
                subject.must_equal("Card cannot be found.")
              end
            end
          end
        end
      end
    end
  end
end
