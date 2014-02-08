require_relative '../../../../test_helper'

module Troo
  describe Persistence::Member do
    let(:described_class) { Persistence::Member }
    let(:resource) do
      OpenStruct.new(
        id:        '5195fdb5a8c01a2318004f5d',
        full_name: resource_full_name)
    end
    let(:resource_full_name) { 'My Test Member' }
    let(:options) { {} }

    before { @member = Fabricate(:member) }
    after  { database_cleanup }

    describe '.initialize' do
      subject { described_class.new(resource, options) }

      it 'assigns the resource to an instance variable' do
        subject.instance_variable_get('@resource')
          .must_equal(resource)
      end

      it 'assigns the options to an instance variable' do
        subject.instance_variable_get('@options').must_equal(options)
      end
    end

    describe '#persist' do
      subject { described_class.for(resource, options) }

      context 'when there is already a local copy' do
        context 'and the local copy is identical' do
          it 'returns the local copy' do
            subject.must_equal(@member)
          end
        end

        context 'and the local copy is out of date' do
          let(:resource_full_name) { 'My Renamed Member' }

          it 'updates and returns the new local copy' do
            subject.full_name.must_equal(resource_full_name)
          end
        end
      end

      context 'when there is not already a local copy' do
        let(:resource_full_name) { 'My New Test Member' }

        before { database_cleanup }

        it 'creates and returns the new local copy' do
          subject.full_name.must_equal(resource_full_name)
        end
      end
    end
  end
end
