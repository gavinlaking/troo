require_relative '../../../test_helper'

module Troo
  module CLI
    describe Add do
      let(:described_class) { Add }

      before do
        Troo::Commands::Add.stubs(:dispatch)
          .returns('could not be created')
      end

      describe '#board' do
        let(:value) {}

        subject do
          capture_io { described_class.new.board(value) }.join
        end

        context 'when a value is provided' do
          let(:value) { 'some value' }

          it { subject.must_be_instance_of(String) }

          it 'returns the output of the command' do
            subject.must_match(/could not be created/)
          end
        end

        context 'when a value is not provided' do
          before { $stdin.stubs(:gets).returns("some value\n") }

          it 'returns the output of the command' do
            subject.must_match(/could not be created/)
          end
        end
      end

      describe '#card' do
        let(:id) {}
        let(:value) {}

        subject do
          capture_io { described_class.new.card(id, value) }.join
        end

        context 'when a value is provided' do
          let(:value) { 'some value' }

          it { subject.must_be_instance_of(String) }

          it 'returns the output of the command' do
            subject.must_match(/could not be created/)
          end
        end

        context 'when a value is not provided' do
          before { $stdin.stubs(:gets).returns("some value\n") }

          it 'returns the output of the command' do
            subject.must_match(/could not be created/)
          end
        end
      end

      describe '#comment' do
        let(:id) {}
        let(:value) {}

        subject do
          capture_io { described_class.new.comment(id, value) }.join
        end

        context 'when a value is provided' do
          let(:value) { 'some value' }

          it { subject.must_be_instance_of(String) }

          it 'returns the output of the command' do
            subject.must_match(/could not be created/)
          end
        end

        context 'when a value is not provided' do
          before { $stdin.stubs(:gets).returns("some value\n") }

          it 'returns the output of the command' do
            subject.must_match(/could not be created/)
          end
        end
      end

      describe '#list' do
        let(:id) {}
        let(:value) {}

        subject do
          capture_io { described_class.new.list(id, value) }.join
        end

        context 'when a value is provided' do
          let(:value) { 'some value' }

          it { subject.must_be_instance_of(String) }

          it 'returns the output of the command' do
            subject.must_match(/could not be created/)
          end
        end

        context 'when a value is not provided' do
          before { $stdin.stubs(:gets).returns("some value\n") }

          it 'returns the output of the command' do
            subject.must_match(/could not be created/)
          end
        end
      end
    end
  end
end
