require_relative '../../../../test_helper'

module Troo
  module Commands
    describe Status do
      let(:described_class) { Status }
      let(:klass) { Troo::Board }
      let(:default) { true }

      before { API::Client.stubs(:perform) }

      describe '.dispatch' do
        subject { described_class.dispatch(klass) }

        before { Fabricate(:board, default: default) }
        after  { database_cleanup }

        it { subject.must_be_instance_of(String) }

        context 'when a default is set' do
          it 'returns a polite message' do
            subject.must_match(/1 board found/)
          end

          it 'returns the name of the resource' do
            subject.must_match(/My Test Board/)
          end
        end

        context 'when no default is set' do
          let(:default) { false }

          context 'and the resource exists' do
            it 'returns a polite message' do
              subject.must_match(/No default board set/)
            end
          end

          context 'and no resources exist' do
            before { klass.stubs(:count).returns(0) }

            it 'returns a polite message' do
              subject.must_match(/No boards found/)
            end
          end
        end
      end
    end
  end
end
