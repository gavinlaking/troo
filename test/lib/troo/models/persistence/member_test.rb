require_relative '../../../../test_helper'

module Troo
  describe Persistence::Member do
    let(:described_class) { Persistence::Member }
    let(:resource) do
      [OpenStruct.new(
        id:        '5195fdb5a8c01a2318004f5d',
        full_name: 'My Test Member')]
    end
    let(:options) { {} }
    let(:klass) { Troo::Member }

    describe '#persist' do
      subject { described_class.with_collection(resource, options) }

      context 'when the local exists' do
        before { @member = Fabricate(:member) }
        after  { database_cleanup }

        it 'deletes the local and persists the remote' do
          @member.delete
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
