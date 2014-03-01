require_relative '../../../test_helper'

module Troo
  module Remote
    describe Member do
      let(:described_class)    { Member }
      let(:resource)           { {} }
      let(:described_instance) { described_class.new(resource) }

      describe '.remote_options' do
        subject { described_class.remote_options }

        it 'returns the default remote options' do
          subject.fetch(:mode).must_equal(:member)
        end
      end

      describe '.by_board_id' do
        subject { described_class.by_board_id }

        it 'returns the resource parameters' do
          subject.fetch(:endpoint).must_equal(:members_by_board_id)
        end
      end

      describe '.by_member_id' do
        subject { described_class.by_member_id }

        it 'returns the resource parameters' do
          subject.fetch(:endpoint).must_equal(:member_by_id)
        end
      end

      describe '#associations' do
        subject { described_instance.associations }

        it { subject.must_equal [] }
      end

      describe '#local_model' do
        subject { described_instance.local_model }

        it { subject.must_equal Troo::Member }
      end

      describe '#adaptor' do
        subject { described_instance.adaptor }

        it { subject.must_equal Adaptors::Member }
      end
    end
  end
end
