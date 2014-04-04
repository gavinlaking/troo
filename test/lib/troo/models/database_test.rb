require_relative '../../../test_helper'

module Troo
  describe Database do
    let(:described_class) { Database }
    let(:configuration)   { stub(database: '1') }
    let(:options)         { {} }

    before  { Ohm.stubs(:connect) }

    describe '#connect' do
      subject { described_class.connect(configuration, options) }

      it 'connects to the persistence layer' do
        subject.must_equal(nil)
      end
    end
  end
end