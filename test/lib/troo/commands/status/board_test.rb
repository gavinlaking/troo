require_relative "../../../../test_helper"

module Troo
  module Commands
    module Status
      describe Board do
        let(:described_class) { Board }
        let(:default) { true }

        describe ".dispatch" do
          subject { described_class.dispatch }

          before { @board = Fabricate(:board, default: default) }
          after  { database_cleanup }

          context "when a default is set" do
            it "returns a polite message" do
              subject.must_match(/1 board found/)
            end
          end

          context "when no default is set" do
            let(:default) { false }

            context "and the resource exists" do
              it "returns a polite message" do
                subject.must_match(/No default board set/)
              end
            end

            context "and no resources exist" do
              before { Troo::Board.stubs(:count).returns(0) }

              it "returns a polite message" do
                subject.must_match(/No boards found/)
              end
            end
          end
        end
      end
    end
  end
end
