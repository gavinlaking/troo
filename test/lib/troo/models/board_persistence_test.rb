require_relative "../../../test_helper"

module Troo
  describe BoardPersistence do
    let(:described_class) { BoardPersistence }
    let(:resource) { OpenStruct.new({
      id:     "526d8e130a14a9d846001d96",
      name:   resource_name,
      description:   "A very brief description...",
      closed: false
    }) }
    let(:resource_name) { "My Test Board" }
    let(:options) { {} }

    before do
      @board = Fabricate(:board)
    end

    after { database_cleanup }

    describe ".initialize" do
      subject { described_class.new(resource, options) }

      it "assigns the resource to an instance variable" do
        subject.instance_variable_get("@resource").must_equal(resource)
      end

      it "assigns the options to an instance variable" do
        subject.instance_variable_get("@options").must_equal(options)
      end
    end

    describe "#persist" do
      subject { described_class.for(resource, options) }

      context "when an identical copy already exists locally" do
        it "returns the local copy" do
          subject.must_equal(@board)
        end
      end

      context "when the local copy is out of date" do
        let(:resource_name) { "My Renamed Board" }

        it "updates and returns the new local copy" do
          subject.name.must_equal("My Renamed Board")
        end
      end

      context "when there is no local copy" do
        let(:resource_name) { "My New Test Board" }

        before do
          database_cleanup
        end

        it "creates and returns the new local copy" do
          subject.name.must_equal("My New Test Board")
        end
      end
    end
  end
end

