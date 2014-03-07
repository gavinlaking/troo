require_relative '../../../../test_helper'

module Troo
  describe Behaviours::NullEntity do
    let(:described_class) { Behaviours::NullEntity }

    describe '#default?' do
      subject { described_class.new.default? }

      it { subject.must_equal false }
    end
  end

  describe Behaviours::SetDefault do
    let(:described_class) { Behaviours::SetDefault }

    describe '#set_default!' do
      before do
        @board_1 = Fabricate(:board, default: true)
        @board_2 = Fabricate(:board, default: false)
      end

      after { database_cleanup }

      subject { described_class.for(entity) }

      context 'when the entity is already the default' do
        let(:entity) { @board_1 }

        it { subject.must_equal true }
      end

      context 'when the entity is not already the default' do
        let(:entity) { @board_2 }

        it 'sets the specified entity to be the default' do
          subject.default.must_equal(true)

          subject.must_equal(@board_2)
        end
      end
    end
  end
end
