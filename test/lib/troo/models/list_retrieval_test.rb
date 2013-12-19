require_relative "../../../test_helper"

module Troo
  describe ListRetrieval do
    let(:described_class) { ListRetrieval }

    before do
      database_cleanup
    end

    describe ".current" do
      subject { described_class.current }

      before do
        @current = Troo::List.create(current: current)
      end

      after do
        @current.delete
      end

      context "when current is set" do
        let(:current) { true }

        it "returns the current" do
          subject.must_equal @current
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
      before do
        @list = Troo::List.create({
                  name:             "My Test List",
                  external_list_id: "526d8e130a14a9d846001d97" })
      end

      after do
        @list.delete
      end

      context "without an ID" do
        subject { described_class.retrieve }

        it "retrieves all locally stored lists" do
          subject.size.must_equal 1
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
          before do
            @list.delete
            ExternalList.stubs(:fetch).returns(remote_list)
          end

          let(:id) { "526d_remote_list_005259" }
          let(:remote_list) { [Troo::List.new({
                                 name:             "My Remote Test List",
                                 external_list_id: id })] }

          it "returns the correct list" do
            subject.name.must_equal("My Remote Test List")
          end
        end
      end
    end
  end
end
