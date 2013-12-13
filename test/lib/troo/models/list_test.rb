require_relative "../../../test_helper"

module Troo
  describe List do
    let(:described_class) { List }

    describe ".current" do
      subject { described_class.current }

      before do
        described_class.stubs(:first).returns(current_list)
      end

      describe "when current is set" do
        let(:current_list) { Troo::List.new(current: true) }

        it "returns the current list" do
          subject.must_equal current_list
        end
      end

      describe "when current is not set" do
        let(:current_list) { nil }

        it "raises an exception" do
          proc { subject }.must_raise(StandardError)
        end
      end
    end
  end
end
