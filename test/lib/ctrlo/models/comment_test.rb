require_relative "../../../test_helper"

module Ctrlo
  describe Comment do
    let(:described_class) { Comment }

    describe ".retrieve" do
      describe "without an ID" do
        subject { described_class.retrieve }

        it "retrieves all locally stored members" do
          skip
        end
      end

      describe "with an ID" do
        subject { described_class }

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

    describe ".persist" do
      subject { described_class.persist }

      it "" do
        skip
      end
    end

    describe "#internal_attributes" do
      subject { described_class }

      it "" do
        skip
      end
    end

    describe "#external_attributes" do
      subject { described_class }

      it "" do
        skip
      end
    end
  end
end

