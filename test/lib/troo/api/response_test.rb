require_relative '../../../test_helper'

module Troo
  module API
    describe Response do
      let(:described_class) { Response }
      let(:parameters)      { {} }

      describe '#initialize' do
        subject { described_class.new(parameters) }

        it 'returns a new instance of the class' do
          subject.must_be_instance_of Response
        end
      end
    end

    describe ErrorResponse do
      let(:described_class) { ErrorResponse }
      let(:parameters)      { {} }

      describe '#initialize' do
        subject { described_class.new(parameters) }

        it 'returns a new instance of the class' do
          subject.must_be_instance_of ErrorResponse
        end
      end
    end
  end
end
