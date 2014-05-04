require_relative '../../../test_helper'

module Troo
  module GUI
    describe Main do
      let(:described_class) { Main }
      let(:argv)            {}
      let(:options)         { {} }

      describe '#bootstrap' do
        subject { described_class.new(argv, options).bootstrap }
      end
    end
  end
end
