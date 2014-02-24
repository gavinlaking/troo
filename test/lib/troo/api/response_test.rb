require_relative '../../../test_helper'

module Troo
  module API
    describe Response do
      let(:described_class) { Response }
      let(:api_response)    { stub(body: body) }
      let(:body)            { '{"key":"some_value"}' }

      describe '#initialize' do
        subject { described_class.new(api_response) }

        it 'assigns the api_response to an instance variable' do
          subject.instance_variable_get('@api_response')
            .must_equal(api_response)
        end
      end

      describe '#parse' do
        subject { described_class.parse(api_response) }

        it 'returns the parsed JSON response' do
          subject.must_equal('key' => 'some_value')
        end
      end
    end
  end
end
