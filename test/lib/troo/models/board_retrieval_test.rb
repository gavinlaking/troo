require_relative "../../../test_helper"

module Troo
  describe BoardRetrieval do
    let(:described_class) { BoardRetrieval }

    describe ".retrieve" do
      describe "without an ID" do
        subject { described_class.retrieve }

        it "retrieves all locally stored boards" do
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
          let(:id) { "526d8f19ddb279532e005259" }

          before do
            Troo::Board.stubs(:get) { nil }
          end

          it "" do
            skip
          end
        end

        describe "remote retrieval by either ID" do
          let(:id) { "526d8f19ddb279532e005259" }

          before do
            Troo::Board.stubs(:get) { nil }
            Troo::Board.stubs(:first) { nil }
          end

          it "" do
            skip
          end
        end
      end
    end
  end
end
