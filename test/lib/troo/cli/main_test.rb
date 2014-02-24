require_relative '../../../test_helper'

module Troo
  module CLI
    describe Main do
      let(:described_class) { Main }

      describe '#init' do
        let(:exists) { false }

        before do
          File.stubs(:exist?).returns(exists)
          FileUtils.stubs(:cp)
        end

        subject { capture_io { described_class.new.init }.join }

        context 'when a configuration file exists' do
          let(:exists) { true }

          it 'returns the output of the command' do
            subject.must_match(/already exists/)
          end
        end

        context 'when a configuration file does not exist' do
          it 'returns the output of the command' do
            subject.must_match(/does not exist/)
          end
        end
      end

      describe '#status' do
        subject { capture_io { described_class.new.status }.join }

        it 'returns the output of the command' do
          subject.must_match(/Status/)
        end
      end

      describe '#cleanup' do
        let(:confirm) { "y\n" }

        before { $stdin.stubs(:gets).returns(confirm) }

        subject { capture_io { described_class.new.cleanup }.join }

        context 'when the user confirms the operation' do
          it 'returns the output of the command' do
            subject.must_match(/All local data has been removed/)
          end
        end

        context 'when the user cancels the operation' do
          let(:confirm) { "n\n" }

          it 'returns the output of the command' do
            subject.must_match(/No local data has been removed/)
          end
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
