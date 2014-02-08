require_relative "../../../../test_helper"

module Troo
  module Commands
    module Default
      describe Board do
        let(:described_class) { Board }
        let(:id) { "1" }

        before do
          @board = Fabricate.build(:board)
          Retrieval::Board.stubs(:retrieve).returns(resource)
        end

        describe ".dispatch" do
          subject { described_class.dispatch(id) }

          context "when the resource exists" do
            let(:resource) { @board }

            it "sets the default and returns a polite message" do
              subject.must_match(/set as default/)
            end
          end

          context "when the resource does not exist" do
            let(:resource) { }

            it "returns a polite message" do
              subject.must_match(/cannot be found/)
            end
          end
        end
      end
    end
  end
end
