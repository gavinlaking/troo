require_relative "../../../test_helper"

module Ctrlo
  describe CardRetrieval do
    let(:described_class) { CardRetrieval }

    describe ".retrieve" do
      describe "without an ID" do
        subject { described_class.retrieve }

        it "retrieves all locally stored cards" do
          skip
        end
      end

      describe "with an ID" do
        subject { described_class.retrieve(id) }

        let(:id) { }

        describe "local retrieval by database ID" do
          it "" do
            skip
          end
        end

        describe "local retrieval by external ID" do
          it "" do
            skip
          end
        end

        describe "remote retrieval by either ID" do
          it "" do
            skip
          end
        end
      end
    end
  end
end
