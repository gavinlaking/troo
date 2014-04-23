require_relative '../../test_helper'

module Troo
  describe Database do
    let(:described_class) { Database }
    let(:configuration)   { stub(database: '1') }
    let(:options)         { {} }

    before  { Ohm.stubs(:connect) }

    subject { described_class.new(configuration, options) }

    it { subject.must_be_instance_of(Troo::Database) }

    describe '#connect' do
      subject { described_class.connect(configuration, options) }

      it { subject.must_be_instance_of(NilClass) }

      it 'connects to the persistence layer' do
        subject.must_equal(nil)
      end
    end
  end
end
