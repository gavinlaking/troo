require_relative '../../../test_helper'

module Troo
  module API
    describe Endpoints do
      let(:described_class) { Endpoints }

      describe '#interpolate' do
        let(:endpoint) { :board_by_id }
        let(:_value)    { { external_id: '20001' } }

        subject { described_class.interpolate(endpoint, _value) }

        it { subject.must_be_instance_of(String) }

        context 'when the endpoint exists' do
          it 'returns the interpolated endpoint' do
            subject.must_equal('/boards/20001')
          end

          context 'but the endpoint does not need interpolation' do
            let(:endpoint) { :boards_all }

            it 'returns the normal endpoint' do
              subject.must_equal('/members/me/boards')
            end
          end
        end

        context 'when the endpoint does not exist' do
          let(:endpoint) { :wrong_endpoint }

          it 'raises an exception' do
            proc { subject }.must_raise(Troo::EndpointNotFound)
          end
        end
      end
    end
  end
end
