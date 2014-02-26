require_relative '../../../test_helper'

module Troo
  module API
    describe Endpoints do
      let(:described_class) { Endpoints }
      let(:file) {}
      let(:version) {}
      let(:endpoints) { { board_by_id: '/boards/%{id}' } }

      before do
        YAML.stubs(:load_file).returns(endpoints)
      end

      describe '.load' do
        subject { described_class.load(file, version) }

        it 'returns a new instance of the class' do
          subject.must_be_instance_of(Endpoints)
        end
      end

      describe '#interpolate!' do
        let(:endpoint) { :board_by_id }
        let(:value)    { { id: '526d8e130a14a9d846001d96' } }

        subject do
          described_class.new(endpoints)
            .interpolate!(endpoint, value)
        end

        context 'when the endpoint exists' do
          it 'returns the interpolated endpoint' do
            subject.must_equal('/boards/526d8e130a14a9d846001d96')
          end
        end

        context 'when the endpoint does not exist' do
          let(:endpoint) { :wrong_endpoint }

          it 'raises an exception' do
            proc { subject }.must_raise(EndpointNotFound)
          end
        end
      end
    end
  end
end
