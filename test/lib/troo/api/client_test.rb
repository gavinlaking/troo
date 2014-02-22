require_relative '../../../test_helper'

module Troo
  module API
    describe Client do
      let(:described_class) { Client }
      let(:parameters) do
        {
          verb:          :get,
          endpoint:      endpoint,
          interpolation: { external_id: '1' },
          model:         Remote::Board,
          query:         {}
        }
      end
      let(:endpoint) { :board_by_id }
      let(:response) { [] }

      before do
        API::Request.stubs(:make).returns(response)
      end

      describe '#perform' do
        subject { described_class.perform(parameters) }

        context 'when all required parameters are provided' do
          context 'and the API request returns a collection' do
            let(:response) do
              [{ name: 'Board 1' }, { name: 'Board 2' }]
            end

            it 'builds the remote model' do
              subject.size.must_equal(2)
            end
          end

          context 'and the API request returns an instance' do
            let(:response) { { name: 'Board 1' } }

            it 'builds the remote model' do
              subject.size.must_equal(1)
            end
          end
        end

        context 'when a required parameter is missing' do
          let(:endpoint) {}

          it { subject.must_equal [] }
        end

        context 'when the response is an error' do
          let(:response) { ErrorResponse.new }

          it { subject.must_equal [] }
        end
      end
    end
  end
end
