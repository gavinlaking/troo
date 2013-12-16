require_relative "../../../test_helper"

module Troo
  describe ListPersistence do
    let(:described_class) { ListPersistence }

    before do
      Ohm.redis.flushall
      @list = Troo::List.create({
        name:              "My Test List",
        closed:            false,
        external_list_id: "526d8e130a14a9d846001d97"
      })
    end

    after do
      @list.delete
    end

    describe "#persist" do
      subject { described_class.for(resource) }

      describe "when an identical copy already exists locally" do
        let(:resource) { OpenStruct.new({
          id:     "526d8e130a14a9d846001d97",
          name:   "My Test List",
          closed: false
        }) }

        it "returns the local copy" do
          subject.must_equal(@list)
        end
      end

      describe "when the local copy is out of date" do
        let(:resource) { OpenStruct.new({
          id:     "526d8e130a14a9d846001d97",
          name:   "My Renamed List",
          closed: false
        }) }

        it "updates and returns the new local copy" do
          subject.name.must_equal("My Renamed List")
        end
      end

      describe "when there is no local copy" do
        before do
          @list.delete
        end

        let(:resource) { OpenStruct.new({
          id:     "526d8e130a14a9d846001d97",
          name:   "My New Test List",
          closed: false
        }) }

        it "creates and returns the new local copy" do
          subject.name.must_equal("My New Test List")
        end
      end
    end
  end
end

