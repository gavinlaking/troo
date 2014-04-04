require_relative '../../../test_helper'

module Troo
  module API
    describe Client do
      let(:described_class) { Client }
      let(:parameters)      {
        {
          verb:          :get,
          endpoint:      endpoint,
          interpolation: { external_id: '1' },
          model:         Remote::Board,
          query:         {}
        }
      }
      let(:endpoint) { :board_by_id }
      let(:response) { Response.new }
      let(:parsed_response) { '' }
      let(:allow_remote) { true }

      before do
        API::Request.stubs(:make).returns(response)
        Yajl::Parser.stubs(:parse).returns(parsed_response)
      end

      describe '#perform' do
        subject { described_class.perform(parameters) }

        context 'when all required parameters are provided' do
          context 'and the API request returns a collection' do
            let(:parsed_response) {
              [{ name: 'Board 1' }, { name: 'Board 2' }]
            }

            it 'builds the remote model' do
              subject.size.must_equal(2)
            end
          end

          context 'and the API request returns an instance' do
            let(:parsed_response) { { name: 'Board 1' } }

            it 'builds the remote model' do
              subject.size.must_equal(1)
            end
          end
        end

        context 'when remote connections are not allowed' do
          let(:allow_remote) { false }

          it { subject.must_equal [] }
        end

        context 'when remote connections are allowed' do
          context 'when a required parameter is missing' do
            let(:endpoint) {}

            it { subject.must_equal [] }
          end

          context 'when the response is an error' do
            let(:response) { ErrorResponse.new }

            it { subject.must_equal [] }
          end

          context 'when the response is empty' do
            it { subject.must_equal [] }
          end
        end
      end
    end
  end
end
