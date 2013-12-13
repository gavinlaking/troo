require_relative "../../../test_helper"

module Troo
  describe ListRetrieval do
    let(:described_class) { ListRetrieval }

    describe ".current" do
      subject { described_class.current }

      before do
        Troo::List.stubs(:first).returns(current_list)
      end

      describe "when current is set" do
        let(:current_list) { Troo::List.new(current: true) }

        it "returns the current list" do
          subject.must_equal current_list
        end
      end

      describe "when current is not set" do
        let(:current_list) { nil }

        it "returns nil" do
          subject.must_equal current_list
        end
      end
    end

    describe ".retrieve" do
      describe "without an ID" do
        subject { described_class.retrieve }

        it "retrieves all locally stored " do
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
