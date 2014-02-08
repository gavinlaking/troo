require_relative "../../../../test_helper"

module Troo
  module Commands
    module Status
      describe List do
        let(:described_class) { List }
        let(:default) { true }

        describe ".dispatch" do
          subject { described_class.dispatch }

          before { @list = Fabricate(:list, default: default) }
          after  { database_cleanup }

          context "when a default is set" do
            it "returns a polite message" do
              subject.must_match(/1 list found/)
            end
          end

          context "when no default is set" do
            let(:default) { false }

            context "and the resource exists" do
              it "returns a polite message" do
                subject.must_match(/No default list set/)
              end
            end

            context "and no resources exist" do
              before { Troo::List.stubs(:count).returns(0) }

              it "returns a polite message" do
                subject.must_match(/No lists found/)
              end
            end
          end
        end
      end
    end
  end
end
