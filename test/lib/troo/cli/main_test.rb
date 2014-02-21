require_relative '../../../test_helper'

module Troo
  module CLI
    describe Main do
      let(:described_class) { Main }

      describe '#init' do
        before { File.stubs(:exist?).returns(true) }

        subject { capture_io { described_class.new.init }.join }

        it 'returns the output of the command' do
          subject.must_match(/configuration file already exists/)
        end
      end

      describe '#status' do
        subject { capture_io { described_class.new.status }.join }

        it 'returns the output of the command' do
          subject.must_match(/Status/)
        end
      end

      describe '#cleanup' do
        subject { capture_io { described_class.new.cleanup }.join }

        it 'returns the output of the command' do
          skip('Needs a spec, please write one.')
        end
      end

      describe '#version' do
        subject { capture_io { described_class.new.version }.join }

        it 'returns the output of the command' do
          subject.must_match(/#{Troo::VERSION}/)
        end
      end

      describe '#move' do
        let(:card_id)  {}
        let(:list_id)  {}
        let(:board_id) {}

        subject do
          capture_io do
            described_class.new.move(card_id, list_id, board_id)
          end.join
        end

        it 'returns the output of the command' do
          subject.must_match(/Card cannot be found/)
        end
      end
    end
  end
end
