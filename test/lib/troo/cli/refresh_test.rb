require_relative '../../../test_helper'

module Troo
  module CLI
    describe Refresh do
      let(:described_class) { Refresh }

      describe '#all' do
        before { Retrieval::Remote.stubs(:fetch).returns([]) }

        subject { capture_io { described_class.new.all }.join }

        it 'returns the output of the command' do
          subject.must_match(/Cannot refresh all local data/)
        end
      end

      describe '#board' do
        subject { capture_io { described_class.new.board }.join }

        it 'returns the output of the command' do
          subject.must_match(/Board cannot be found/)
        end
      end

      describe '#card' do
        subject { capture_io { described_class.new.card }.join }

        it 'returns the output of the command' do
          subject.must_match(/Card cannot be found/)
        end
      end

      describe '#list' do
        subject { capture_io { described_class.new.list }.join }

        it 'returns the output of the command' do
          subject.must_match(/List cannot be found/)
        end
      end
    end
  end
end
