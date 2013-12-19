require_relative "../../../test_helper"

module Troo
  describe OverviewPresenter do
    let(:described_class) { OverviewPresenter }
    let(:board) { }
    let(:options) { { } }

    before do
      Ohm.redis.flushdb
    end

    after do
    end

    describe "#initialize" do
      subject { described_class.new(board, options) }

      it "assigns the board to an instance variable" do
        subject.instance_variable_get("@board").must_equal(board)
      end

      it "assigns the optiosn to an instance variable" do
        subject.instance_variable_get("@options").must_equal(options)
      end
    end

    describe ".render" do
      subject { described_class.render(board, options) }
    end
  end
end
