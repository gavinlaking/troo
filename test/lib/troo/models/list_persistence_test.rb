require_relative "../../../test_helper"

module Troo
  describe ListPersistence do
    let(:described_class) { ListPersistence }
    let(:resource) { OpenStruct.new({
      id:     "526d8e130a14a9d846001d97",
      name:   resource_name,
      closed: false
    }) }

    before do
      @list = Fabricate(:list)
    end

    after do
      database_cleanup
    end

    describe "#persist" do
      subject { described_class.for(resource) }

      context "when an identical copy already exists locally" do
        let(:resource_name) { "My Test List" }

        it "returns the local copy" do
          subject.must_equal(@list)
        end
      end

      context "when the local copy is out of date" do
        let(:resource_name) { "My Renamed List" }

        it "updates and returns the new local copy" do
          subject.name.must_equal("My Renamed List")
        end
      end

      context "when there is no local copy" do
        let(:resource_name) { "My New Test List" }

        before do
          database_cleanup
        end

        it "creates and returns the new local copy" do
          subject.name.must_equal("My New Test List")
        end
      end
    end
  end
end

