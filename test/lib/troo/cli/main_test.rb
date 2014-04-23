require_relative '../../../test_helper'

module Troo
  module CLI
    describe Main do
      let(:described_class) { Main }

      describe '#status' do
        before  { Commands::Status.stubs(:dispatch) }

        subject { capture_io { described_class.new.status }.join }

        it { subject.must_be_instance_of(String) }

        it 'returns the output of the command' do
          subject.must_match(/Status/)
        end

        it 'returns the last refresh time' do
          subject.must_match(/Last refreshed/)
        end
      end

      describe '#config' do
        subject { capture_io { described_class.new.config }.join }

        it { subject.must_be_instance_of(String) }

        it 'returns the current configuration' do
          subject.must_match(/Current configuration/)
        end
      end

      describe '#cleanup' do
        let(:confirm) { "y\n" }

        before { $stdin.stubs(:gets).returns(confirm) }

        subject { capture_io { described_class.new.cleanup }.join }

        it { subject.must_be_instance_of(String) }

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

        it { subject.must_be_instance_of(String) }

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

        it { subject.must_be_instance_of(String) }

        it 'returns the output of the command' do
          subject.must_match(/Card cannot be found/)
        end
      end
    end
  end
end
