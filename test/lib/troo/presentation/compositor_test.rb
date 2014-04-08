require_relative '../../../test_helper'

module Troo
  describe Compositor do
    let(:described_class)    { Compositor }
    let(:described_instance) { described_class.new }

    describe '#build' do
      let(:content) { "An example line of text...\n" }

      subject { described_instance.build(content) }

      context 'when the content is a single line' do
        it 'returns an array containing all built output' do
          subject.must_equal(["An example line of text...\n"])
        end
      end

      context 'when the content is a collection' do
        let(:content) { ["An example\n", "collection of\n", "lines...\n"] }

        it 'returns an array containing all built output' do
          subject.must_equal(["An example\n", "collection of\n", "lines...\n"])
        end
      end

      context 'when indentation is set' do
        let(:content) { ["testing\n", "1... 2... 3...\n"] }

        before  { @cmp = described_instance }

        subject do
          @cmp.indent { @cmp.build(content) }
        end

        it 'renders the contents indented' do
          subject.must_equal ["    testing\n",
                              "    1... 2... 3...\n"]
        end
      end

      context 'when no indentation set' do
        let(:content) { ["testing\n", "1... 2... 3...\n"] }

        subject do
          described_instance.build(content)
        end

        it 'renders the contents as normal' do
          subject.must_equal ["testing\n",
                              "1... 2... 3...\n"]
        end
      end
    end
  end
end
