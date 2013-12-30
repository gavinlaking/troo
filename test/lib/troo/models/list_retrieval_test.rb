require_relative "../../../test_helper"

module Troo
  describe ListRetrieval do
    let(:described_class) { ListRetrieval }
    let(:current) { true }
    let(:list_name) { "My Test List" }

    before do
      @list = Fabricate(:list, current: current, name: list_name)
    end

    after do
      database_cleanup
    end

    describe ".all" do
      subject { described_class.all }

      it "retrieves all locally stored lists" do
        subject.size.must_equal 1
      end
    end

    describe ".current" do
      subject { described_class.current }

      context "when current is set" do
        it "returns the current" do
          subject.must_equal @list
        end
      end

      context "when current is not set" do
        let(:current) { false }

        it "returns nil" do
          subject.must_equal nil
        end
      end
    end

    describe ".retrieve" do
      context "without an ID" do
        subject { described_class.retrieve }

        context "when current is set" do
          it "returns the current" do
            subject.must_equal @list
          end
        end

        context "when current is not set" do
          let(:current) { false }

          it "returns nil" do
            subject.must_equal nil
          end
        end
      end

      context "with an ID" do
        subject { described_class.retrieve(id) }

        context "local retrieval by database ID" do
          let(:id) { @list.id }

          it "returns the correct list" do
            subject.name.must_equal("My Test List")
          end
        end

        context "local retrieval by external ID" do
          let(:id) { "526d8e130a14a9d846001d97" }

          it "returns the correct list" do
            subject.name.must_equal("My Test List")
          end
        end

        context "remote retrieval by either ID" do
          let(:id) { "526d_remote_list_005259" }
          let(:list_name) { "My Remote Test List" }

          before do
            ExternalList.stubs(:fetch).returns([@list])
          end

          it "returns the correct list" do
            subject.name.must_equal("My Remote Test List")
          end
        end

        context "when the ID cannot be found" do
          let(:id) { "not_found_id" }

          before { ExternalList.stubs(:fetch).returns([]) }

          it "returns nil" do
            subject.must_equal nil
          end
        end
      end
    end
  end
end
