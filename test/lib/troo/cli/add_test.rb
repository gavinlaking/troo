require_relative '../../../test_helper'

module Troo
  module CLI
    describe Add do
      let(:described_class) { Add }

      describe '#board' do
        let(:value) {}

        subject do
          capture_io { described_class.new.board(value) }.join
        end

        it 'returns the output of the command' do
          skip('Needs a spec, please write one.')
        end
      end

      describe '#card' do
        let(:id) {}
        let(:value) {}

        subject do
          capture_io { described_class.new.card(id, value) }.join
        end

        it 'returns the output of the command' do
          skip('Needs a spec, please write one.')
        end
      end

      describe '#comment' do
        let(:id) {}
        let(:value) {}

        subject do
          capture_io { described_class.new.comment(id, value) }.join
        end

        it 'returns the output of the command' do
          skip('Needs a spec, please write one.')
        end
      end

      describe '#list' do
        let(:id) {}
        let(:value) {}

        subject do
          capture_io { described_class.new.list(id, value) }.join
        end

        it 'returns the output of the command' do
          skip('Needs a spec, please write one.')
        end
      end
    end
  end
end
