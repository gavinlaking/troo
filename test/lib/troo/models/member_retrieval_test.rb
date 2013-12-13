require_relative "../../../test_helper"

module Troo
  describe MemberRetrieval do
    let(:described_class) { MemberRetrieval }

    describe ".retrieve" do
      describe "without an ID" do
        subject { described_class.retrieve }

        it "retrieves all locally stored members" do
          skip
        end
      end

      describe "with an ID" do
        subject { described_class.retrieve(id) }

        describe "local retrieval by database ID" do
          let(:id) { }

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
