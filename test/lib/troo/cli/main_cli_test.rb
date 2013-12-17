require_relative "../../../test_helper"
require "thor"

module Troo
  module CLI
    describe Main do
      let(:described_class) { Main }

      describe "#refresh" do
        subject { described_class.new.refresh }

        it "does something" do
          subject.must_equal("Not implemented yet.")
        end
      end

      describe "#cleanup" do
        subject { described_class.new.cleanup }

        it "does something" do
          subject.must_equal("Not implemented yet.")
        end
      end

      describe "#version" do
        subject { described_class.new.version }

        it "does something" do
          subject.must_equal("Not implemented yet.")
        end
      end

      describe "#comment" do
        let(:card_id) { "526d8f19ddb279532e005259" }
        let(:comment) { }

        subject { described_class.new.comment(card_id, comment) }

        it "does something" do
          subject.must_equal("Not implemented yet.")
        end
      end

      describe "#move" do
        let(:card_id) { "526d8f19ddb279532e005259" }
        let(:list_id) { "526d8e130a14a9d846001d97" }

        subject { described_class.new.move(card_id, list_id) }

        it "does something" do
          subject.must_equal("Not implemented yet.")
        end
      end
    end
  end
end
