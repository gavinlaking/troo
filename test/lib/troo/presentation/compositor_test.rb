require_relative '../../../test_helper'

module Troo
  describe Compositor do
    let(:described_class)    { Compositor }
    let(:described_instance) { described_class.new }

    describe '#render' do
      subject { described_instance.render(lines) }
    end

    describe '#spacer' do
      subject { described_instance.spacer { } }
    end

    describe '#indent' do
      subject { described_instance.indent { } }
    end
  end
end
