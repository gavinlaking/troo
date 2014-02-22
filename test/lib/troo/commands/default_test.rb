require_relative '../../../test_helper'

module Troo
  module Commands
    describe Default do
      let(:described_class) { Default }
      let(:klass)           { stub }
      let(:id)              {}
      let(:resource)        { stub }
      let(:outcome)         { true }
      let(:decorator)       { OpenStruct.new(name: 'Test') }

      before do
        API::Client.stubs(:perform)
        klass.stubs(:retrieve).returns(resource)
        resource.stubs(:set_default!).returns(outcome)
        resource.stubs(:decorator).returns(decorator)
      end

      describe '#initialize' do
        subject { described_class.new(klass, id) }

        it 'assigns the klass to an instance variable' do
          subject.instance_variable_get('@klass').must_equal(klass)
        end

        it 'assigns the id to an instance variable' do
          subject.instance_variable_get('@id').must_equal(id)
        end
      end

      describe '.dispatch' do
        subject { described_class.dispatch(klass, id) }

        context 'when the resource exists' do
          it 'sets the default and returns a polite message' do
            subject.must_match(/set as default/)
          end
        end

        context 'when the resource does not exist' do
          let(:outcome) { false }

          it 'returns a polite message' do
            subject.must_match(/cannot be found/)
          end
        end
      end
    end
  end
end
