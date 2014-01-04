require_relative "../../../test_helper"

module Troo
  describe ListRetrieval do
    let(:described_class) { ListRetrieval }
    let(:default) { true }
    let(:list_name) { "My Test List" }

    before do
      @list = Fabricate(:list, default: default, name: list_name)
    end

    after { database_cleanup }

    describe ".all" do
      subject { described_class.all }

      it "retrieves all locally stored lists" do
        subject.size.must_equal 1
      end
    end

    describe ".default" do
      subject { described_class.default }

      context "when default is set" do
        it "returns the default" do
          subject.must_equal @list
        end
      end

      context "when default is not set" do
        let(:default) { false }

        it "returns nil" do
          subject.must_equal nil
        end
      end
    end

    describe ".retrieve" do
      context "without an ID" do
        subject { described_class.retrieve }

        context "when default is set" do
          it "returns the default" do
            subject.must_equal @list
          end
        end

        context "when default is not set" do
          let(:default) { false }

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
