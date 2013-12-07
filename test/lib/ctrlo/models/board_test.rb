require_relative "../../../test_helper"

module Ctrlo
  describe Board do
    let(:described_class) { Board }

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
            Ctrlo::Board.stubs(:get) { nil }
          end

          it "" do
            skip
          end
        end

        describe "remote retrieval by either ID" do
          let(:id) { "526d8f19ddb279532e005259" }

          before do
            Ctrlo::Board.stubs(:get) { nil }
            Ctrlo::Board.stubs(:first) { nil }
          end

          it "" do
            skip
          end
        end
      end
    end

    describe ".persist" do
      subject { described_class.persist(collection) }

      it "" do
        skip
      end
    end

    describe ".current" do
      subject { described_class.current }

      describe "when current is set" do
        it "" do
          skip
        end
      end

      describe "when current is not set" do
        before do
          described_class.stubs(:first) { nil }
        end

        it "raises an exception" do
          proc { subject }.must_raise(StandardError)
        end
      end
    end

    describe "#internal_attributes" do
      subject { described_class.new.internal_attributes }

      it "" do
        skip
      end
    end

    describe "#external_attributes" do
      subject { described_class.new.external_attributes }

      it "" do
        skip
      end
    end
  end
end

