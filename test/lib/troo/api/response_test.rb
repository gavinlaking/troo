require_relative '../../../test_helper'

module Troo
  module API
    describe Responder do
      let(:described_class) { Responder }
      let(:parameters)      { { code: code } }

      subject { described_class.build(parameters) }

      context 'when the status code is 200' do
        let(:code) { '200' }

        it { subject.must_be_instance_of(Troo::API::Response) }
      end

      context 'when the status code is any other value' do
        let(:code) { '410' }

        it { subject.must_be_instance_of(Troo::API::ErrorResponse) }
      end
    end

    describe Response do
      let(:described_class) { Response }
      let(:parameters)      { {} }

      subject { described_class.new(parameters) }

      it { subject.must_be_instance_of(Troo::API::Response) }
    end

    describe ErrorResponse do
      let(:described_class) { ErrorResponse }
      let(:parameters)      { {} }

      subject { described_class.new(parameters) }

      it { subject.must_be_instance_of(Troo::API::ErrorResponse) }
    end
  end
end
