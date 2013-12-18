require_relative "../../../test_helper"
require "thor"

module Troo
  module CLI
    describe Board do
      let(:described_class) { Board }

      describe "#all" do
        subject { capture_io { described_class.new.all }.join }

        # before do
        #   Troo::BoardRetrieval.stubs(:retrieve).returns(boards)
        # end

        # describe "when there are boards to be shown" do
        #   let(:boards) { [Troo::Board.new(id: 1, name: "My Test Board 1"),
        #                   Troo::Board.new(id: 2, name: "My Test Board 2")] }

        #   it "outputs a list of boards" do
        #     skip
        #     proc { subject }.must_output <<-OUTPUT.gsub(/^ {14}/, "")
        #       \e[4m\e[31m1\e[0m My Test Board 1
        #       \e[4m\e[31m2\e[0m My Test Board 2

        #     OUTPUT
        #   end
        # end

        # describe "when there are no boards to be shown" do
        #   let(:boards) { nil }

        #   it "shows an error" do
        #     subject.must_match /No boards found./
        #   end
        # end

        context "when there are boards" do
          it "does something" do
            subject.must_match /Not implemented yet./
          end
        end

        context "when there are no boards" do
          it "does something" do
            subject.must_match /Not implemented yet./
          end
        end
      end

      describe "#show" do
        let(:board_id) { "526d8e130a14a9d846001d96" }

        subject { capture_io { described_class.new.show(board_id) }.join }

        context "when the board exists" do
          # let(:lists) { [ Troo::List.new(id: 1, name: "My Test List 1", cards: cards) ] }
          # let(:cards) { [ Troo::Card.new(id: 1, name: "My Test Card 1") ] }
          # let(:board) { Troo::Board.new(id: 1, name: "My Test Board 1", lists: lists) }

          # before do
          #   #Troo::BoardRetrieval.stubs(:retrieve).returns(board)
          # end

          # it "outputs the board including lists and cards" do
          #   skip
          #   proc { subject }.must_output <<-OUTPUT.gsub(/^ {14}/, "")
          #     \e[4m\e[31m1\e[0m My Test Board 1
          #         \e[4m\e[33m1\e[0m My Test List 1
          #             \e[4m\e[34m\e[0m My Test Card 1

          #   OUTPUT
          # end
          it "does something" do
            subject.must_match /Not implemented yet./
          end
        end

        context "when the board does not exist" do
          # let(:board) { nil }

          # before do
          #   Troo::BoardRetrieval.stubs(:retrieve).raises(Trello::Error)
          # end

          # it "rescues from the error" do
          #   subject.must_match /Board cannot be found./
          # end
          it "does something" do
            subject.must_match /Not implemented yet./
          end
        end
      end
    end
  end
end
