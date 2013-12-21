require_relative "../../../test_helper"

module Troo
  describe SetCurrent do
    let(:described_class) { SetCurrent }
    let(:entity) { }

    before do
    end

    after do
      database_cleanup
    end

    describe ".initialize" do
      subject { described_class.new(entity) }

      it "" do
        skip
      end
    end

    describe "#set_current!" do
      subject { described_class.for(entity) }

      it "" do
        skip
      end
    end
  end
end
