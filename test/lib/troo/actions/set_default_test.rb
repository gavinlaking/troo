require_relative "../../../test_helper"

module Troo
  describe SetDefault do
    let(:described_class) { SetDefault }
    let(:entity) { @board_2 }

    before do
      @board_1 = Fabricate(:board, default: true)
      @board_2 = Fabricate(:board, default: false)
    end

    after do
      database_cleanup
    end

    describe ".initialize" do
      subject { described_class.new(entity) }

      it "assigns the entity to an instance variable" do
        subject.instance_variable_get("@entity").must_equal(entity)
      end
    end

    describe "#set_default!" do
      subject { described_class.for(entity) }

      it "sets the specified entity to be the default" do
        subject.default.must_equal(true)
      end
    end
  end
end
