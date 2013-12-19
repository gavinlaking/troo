require_relative "../../../test_helper"
require "thor"

module Troo
  module CLI
    describe Main do
      let(:described_class) { Main }

      describe "#refresh" do
        subject { capture_io { described_class.new.refresh }.join }

        it "does something" do
          subject.must_match /Not implemented yet./
        end
      end

      describe "#cleanup" do
        subject { capture_io { described_class.new.cleanup }.join }

        it "removes all local data" do
          subject.must_match /All local data has been removed./
        end
      end

      describe "#version" do
        subject { capture_io { described_class.new.version }.join }

        it "prints the version" do
          subject.must_match /troo #{Troo::VERSION}/
        end
      end

      describe "#comment" do
        let(:card_id) { "526d8f19ddb279532e005259" }
        let(:comment) { }

        subject { capture_io { described_class.new.comment(card_id, comment) }.join }

        it "does something" do
          subject.must_match /Not implemented yet./
        end
      end

      describe "#move" do
        let(:card_id) { "526d8f19ddb279532e005259" }
        let(:list_id) { "526d8e130a14a9d846001d97" }

        subject { capture_io { described_class.new.move(card_id, list_id) }.join }

        it "does something" do
          subject.must_match /Not implemented yet./
        end
      end
    end
  end
end
