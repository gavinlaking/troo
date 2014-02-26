require_relative '../../../test_helper'

module Troo
  module API
    describe OAuthSettings do
      let(:described_class) { OAuthSettings }
      let(:parameters) { {} }

      describe '#initialize' do
        subject { described_class.new(parameters) }

        it 'returns a new instance of the class' do
          subject.must_be_instance_of(OAuthSettings)
        end
      end
    end
  end
end
