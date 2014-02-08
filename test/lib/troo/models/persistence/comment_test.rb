require_relative '../../../../test_helper'

module Troo
  describe Persistence::Comment do
    let(:described_class) { Persistence::Comment }
    let(:resource) do
      OpenStruct.new(
        id:   '51f9277b2822b8654f0023af',
        date: '2013-12-17 22:01:13 UTC',
        data: {
          'text' => resource_text,
          'board' => {
            'id' => '526d8e130a14a9d846001d96'
          },
          'card' => {
            'id' => '526d8f19ddb279532e005259'
        }
      })
    end
    let(:resource_text) { 'My Test Comment' }
    let(:options) { {} }

    before { @comment = Fabricate(:comment) }
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
            subject.must_equal(@comment)
          end
        end

        context 'and the local copy is out of date' do
          let(:resource_text) { 'My Renamed Comment' }

          it 'updates and returns the new local copy' do
            subject.text.must_equal(resource_text)
          end
        end
      end

      context 'when there is not already a local copy' do
        let(:resource_text) { 'My New Test Comment' }

        before { database_cleanup }

        it 'creates and returns the new local copy' do
          subject.text.must_equal(resource_text)
        end
      end
    end
  end
end
