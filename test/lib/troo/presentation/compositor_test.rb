require_relative '../../../test_helper'

module Troo
  describe Compositor do
    let(:described_class)    { Compositor }
    let(:described_instance) { described_class.new }

    describe '#render' do
      let(:lines) { ["testing\n", "1... 2... 3...\n"] }

      context 'when indentation is set' do
        before  { @cmp = described_instance }

        subject do
          capture_io do
            @cmp.indent { @cmp.render(lines) }
          end.join
        end

        it 'renders the contents indented' do
          subject.must_equal "    testing\n" \
                             "    1... 2... 3...\n"
        end
      end

      context 'when no indentation set' do
        subject do
          capture_io do
            described_instance.render(lines)
          end.join
        end

        it 'renders the contents as normal' do
          subject.must_equal "testing\n" \
                             "1... 2... 3...\n"
        end
      end
    end

    describe '#spacer' do
      context 'when a block is given' do
        subject do
          capture_io do
            described_instance.spacer { 'testing...' }
          end.join
        end

        it 'renders the contents of the block between line breaks' do
          subject.must_equal("\n\n")
        end
      end

      context 'when a block is not given' do
        subject do
          capture_io do
            described_instance.spacer
          end.join
        end

        it 'renders a single line break' do
          subject.must_equal("\n")
        end
      end
    end
  end
end
