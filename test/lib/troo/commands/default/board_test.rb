require_relative "../../../../test_helper"

module Troo
  module Commands
    module Default
      describe Board do
        let(:described_class) { Board }
        let(:id) { }

        describe "#initialize" do
          subject { described_class.new(id) }

          it "assigns the id to an instance variable" do
            subject.instance_variable_get("@id").must_equal(id)
          end
        end

        describe ".dispatch" do
          subject { described_class.dispatch(id) }

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
