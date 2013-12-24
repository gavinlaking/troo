require_relative "../../test_helper"

module Troo
  describe Input do
    let(:described_class) { Input }
    let(:id) { "526d8e130a14a9d846001d96" }

    before do
    end

    after do
      database_cleanup
    end

    describe "#initialize" do
      subject { described_class.new(id) }

      it "assigns the id to an instance variable" do
        subject.instance_variable_get("@id").must_equal(id)
      end
    end

    describe "#get" do
      let(:filehandle) { "file mock" }
      let(:lines) { ["some input...\n"] }

      subject { described_class.get(id) }

      before do
        described_class.any_instance.stubs(:system)
        File.stubs(:open).returns(filehandle)
        filehandle.stubs(:readlines).returns(lines)
        filehandle.stubs(:close).returns(true)
      end

      it "gets the input from the user" do
        subject.must_equal("some input...\n")
      end
    end
  end
end

