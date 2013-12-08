require_relative "../../../test_helper"
require "thor"

module Ctrlo
  module CLI
    describe List do
      let(:described_class) { List }

      describe "#all" do
        subject { described_class }

        it "" do
          skip
        end
      end

      describe "#cards" do
        subject { described_class }

        it "" do
          skip
        end
      end

      describe "#current" do
        let(:list_id) { "some_list_id" }

        subject { described_class.new.current(list_id) }

        describe "when the list_id cannot be found" do
          before do
            Ctrlo::ListRetrieval.stubs(:retrieve).raises(Trello::Error)
          end

          it "rescues from the error" do
            proc { subject }.must_output("List cannot be found.\n")
          end
        end

        describe "when the list_id was found" do
          let(:list) { Ctrlo::List.new(name: "My List", current: false) }

          before do
            Ctrlo::ListRetrieval.stubs(:retrieve)
            SetCurrent.stubs(:for).returns(list)
          end

          it "reports success" do
            proc { subject }.must_output("List 'My List' set to current.\n")
          end
        end
      end

      describe "#add" do
        subject { described_class }

        it "" do
          skip
        end
      end
    end
  end
end
