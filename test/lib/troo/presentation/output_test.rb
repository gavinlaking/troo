require_relative '../../../test_helper'

module Troo
  describe Output do
    let(:described_class)    { Output }
    let(:described_instance) { described_class.new(output) }
    let(:output)             {}

    describe '#render' do
      subject do
        capture_io do
          described_instance.render
        end.join
      end

      context 'when the output is a single line' do
        let(:output) { "Single line of output...\n" }

        it 'prints the output' do
          subject.must_equal output
        end
      end

      context 'when the output is multi-line' do
        let(:output) { ["Multiple lines\n", "of output\n"] }

        it 'prints the output' do
          subject.must_equal "Multiple lines\n" \
                             "of output\n"
        end
      end
    end
  end
end
