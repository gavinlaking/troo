require_relative "../../../../test_helper"

module Troo
  module Commands
    module Add
      describe List do
        let(:described_class) { List }
        let(:value) { "Add List Test" }
        let(:id)    { }

        before do
          Retrieval::Board.stubs(:retrieve)
          CreateList.stubs(:for).returns(false)
        end

        describe "#add" do
          subject { described_class.new(value, id).add }

          context "when the parent resource exists" do
            context "and the list was created" do
              before { CreateList.stubs(:for).returns(true) }

              it "returns a polite message" do
                subject.must_match(/\'Add List Test\' created/)
              end
            end

            context "and the list was not created" do
              it "returns a polite message" do
                subject.must_match(/could not/)
              end
            end
          end

          context "when the parent resource does not exist" do
            it "returns a polite message" do
              subject.must_match(/could not/)
            end
          end
        end
      end
    end
  end
end
