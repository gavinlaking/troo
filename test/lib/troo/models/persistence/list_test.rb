require_relative '../../../../test_helper'

module Troo
  describe Persistence::List do
    let(:described_class) { Persistence::List }
    let(:resource) do
      [OpenStruct.new(
        id:     '526d8e130a14a9d846001d97',
        name:   resource_name,
        closed: false)]
    end
    let(:resource_name) { 'My Test List' }
    let(:options) { {} }

    let(:klass) { Troo::List }

    describe '#persist' do
      subject { described_class.with_collection(resource, options) }

      context 'when the local exists' do
        let(:default) { false }

        before { @list = Fabricate(:list, default: default) }
        after  { database_cleanup }

        context 'and the local is default' do
          let(:default) { true }

          it 'the remote is set to default' do
            subject.first.default.must_equal(true)
          end
        end

        context 'and the local is not default' do
          it 'the remote is not set to default' do
            subject.first.default.must_equal(false)
          end
        end

        it 'deletes the local and persists the remote' do
          @list.delete
          subject
          klass.count.must_equal 1
        end
      end

      context 'when the local does not exist' do
        it 'persists the remote' do
          klass.count.must_equal 0
          subject
          klass.count.must_equal 1
        end
      end
    end
  end
end
