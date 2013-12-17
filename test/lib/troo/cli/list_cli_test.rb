require_relative "../../../test_helper"
require "thor"

module Troo
  module CLI
    describe List do
      let(:described_class) { List }

      describe "#all" do
        let(:board_id) { "526d8e130a14a9d846001d96" }

        subject { described_class.new.all(board_id) }

        context "when there are lists" do
          it "does something" do
            subject.must_equal("Not implemented yet.")
          end
        end

        context "when there are no lists" do
          it "does something" do
            subject.must_equal("Not implemented yet.")
          end
        end
      end

      describe "#show" do
        let(:list_id) { "526d8e130a14a9d846001d97" }

        subject { described_class.new.show(list_id) }

        context "when the list exists" do
          it "does something" do
            subject.must_equal("Not implemented yet.")
          end
        end

        context "when the list does not exist" do
          it "does something" do
            subject.must_equal("Not implemented yet.")
          end
        end
      end
    end
  end
end
