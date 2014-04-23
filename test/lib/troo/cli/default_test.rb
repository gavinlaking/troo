require_relative '../../../test_helper'

module Troo
  module CLI
    describe Default do
      let(:described_class) { Default }

      describe '#board' do
        let(:id) {}

        subject { capture_io { described_class.new.board(id) }.join }

        it { subject.must_be_instance_of(String) }

        it 'returns the output of the command' do
          subject.must_match(/Board cannot be found/)
        end
      end

      describe '#card' do
        let(:id) {}

        subject { capture_io { described_class.new.card(id) }.join }

        it { subject.must_be_instance_of(String) }

        it 'returns the output of the command' do
          subject.must_match(/Card cannot be found/)
        end
      end

      describe '#list' do
        let(:id) {}

        subject { capture_io { described_class.new.list(id) }.join }

        it { subject.must_be_instance_of(String) }

        it 'returns the output of the command' do
          subject.must_match(/List cannot be found/)
        end
      end
    end
  end
end
