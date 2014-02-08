require_relative '../../../../test_helper'

module Troo
  describe Persistence::Card do
    let(:described_class) { Persistence::Card }
    let(:resource) do OpenStruct.new(
      id:     '526d8f19ddb279532e005259',
      name:   resource_name,
      closed: false
    ) end
    let(:resource_name) { 'My Test Card' }
    let(:options) { {} }

    before { @card = Fabricate(:card) }
    after  { database_cleanup }

    describe '.initialize' do
      subject { described_class.new(resource, options) }

      it 'assigns the resource to an instance variable' do
        subject.instance_variable_get('@resource').must_equal(resource)
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
            subject.must_equal(@card)
          end
        end

        context 'and the local copy is out of date' do
          let(:resource_name) { 'My Renamed Card' }

          it 'updates and returns the new local copy' do
            subject.name.must_equal(resource_name)
          end
        end
      end

      context 'when there is not already a local copy' do
        let(:resource_name) { 'My New Test Card' }

        before { database_cleanup }

        it 'creates and returns the new local copy' do
          subject.name.must_equal(resource_name)
        end
      end
    end
  end
end
