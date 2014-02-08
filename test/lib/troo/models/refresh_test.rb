require_relative '../../../test_helper'

module Troo
  describe Refresh do
    let(:described_class) { Refresh }
    let(:described_instance) { Fabricate.build(:refresh) }

    subject { described_instance }

    context 'attributes' do
      it 'should have a last_performed_at attribute' do
        subject.last_performed_at.must_equal Time.parse('2014-01-16 21:00:00 UTC')
      end
    end

    context 'actions' do
      before { @refresh = Fabricate(:refresh) }
      after  { database_cleanup }

      describe '.completed!' do
        subject { described_class.completed! }

        it 'updates the last performed at timestamp' do
          subject.wont_equal @refresh.last_performed_at
        end
      end

      describe '.last_performed_at?' do
        subject { described_class.last_performed_at? }

        context 'when one has not been performed' do
          before { @refresh.delete }

          it { subject.must_equal(nil) }
        end

        context 'when one has been performed' do
          it 'returns the last performed timestamp' do
            subject.must_equal @refresh.last_performed_at
          end
        end
      end
    end
  end
end
