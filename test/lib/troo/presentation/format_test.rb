require_relative '../../../test_helper'

module Troo
  describe Format do
    let(:described_class)    { Format }
    let(:described_instance) { described_class.new }

    describe '#underline' do
      subject { described_instance.underline }
    end
  end
end
