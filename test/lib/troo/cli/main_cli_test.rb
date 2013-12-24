require_relative "../../../test_helper"
require "thor"

module Troo
  module CLI
    describe Main do
      let(:described_class) { Main }

      before do
      end

      after do
        database_cleanup
      end

      describe "#refresh" do
        subject { capture_io { described_class.new.refresh }.join }

        before do
          RefreshAll.stubs(:perform)
        end

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

      describe "#move" do
        let(:card_id)   { "526d8f19ddb279532e005259" }
        let(:list_id)   { "526d8e130a14a9d846001d98" }
        let(:move_card) { OpenStruct.new(external_card_id: card_id,
                                         source_list_id: @card.external_list_id,
                                         source_list_name: @card.list.name,
                                         destination_list_id: list_id,
                                         destination_list_name: @destination_list.name) }

        before do
          @card = Fabricate(:card)
          @list = Fabricate(:list)
          @destination_list = Fabricate(:list, name: "My New List", external_list_id: list_id)
          Troo::ExternalCard.stubs(:fetch).returns(@card)
          Troo::MoveCard.stubs(:with).returns(move_card)
        end

        subject { capture_io { described_class.new.move(card_id, list_id) }.join }

        it "moves the card and returns a polite message" do
          subject.must_match /Card moved from/
        end
      end
    end
  end
end
