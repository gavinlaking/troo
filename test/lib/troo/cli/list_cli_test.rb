require_relative "../../../test_helper"
require "thor"

module Troo
  module CLI
    describe List do
      let(:described_class) { List }
      let(:list_id)         { "526d8e130a14a9d846001d97" }

      before do
        @board  = Fabricate(:board)
        @list   = Fabricate(:list)
        @card   = Fabricate(:card)
      end

      after do
        database_cleanup
      end

      describe "#show" do
        subject { capture_io { described_class.new.show(list_id) }.join }

        context "when the list exists" do
          it "returns the list's board, the list and all cards" do
            subject.must_match /Test Board/
            subject.must_match /Test List/
            subject.must_match /Test Card/
          end
        end

        context "when the list does not exist" do
          before do
            Troo::ListRetrieval.stubs(:retrieve).returns()
          end

          it "returns a polite message" do
            subject.must_match /List not found./
          end
        end
      end
    end
  end
end
