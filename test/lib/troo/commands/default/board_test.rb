require_relative "../../../../test_helper"

module Troo
  module Commands
    module Default
      describe Board do
        let(:described_class) { Board }
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
              subject.must_equal("'#{resource_name}' set as default board.")
            end
          end

          context "when the board cannot be found" do
            it "returns a polite message" do
              subject.must_equal("Board cannot be found.")
            end
          end
        end
      end
    end
  end
end
