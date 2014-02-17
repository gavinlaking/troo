require_relative '../../../../test_helper'

module Troo
  describe Retrieval::Member do
    let(:described_class) { Retrieval::Member }
    let(:full_name) { 'My Test Member' }

    before { @member = Fabricate(:member, full_name: full_name) }
    after  { database_cleanup }

    describe '.all' do
      subject { described_class.all }

      it 'retrieves all locally stored members' do
        subject.size.must_equal 1
      end
    end

    describe '.retrieve' do
      subject { described_class.retrieve(id) }

      context 'local retrieval by database ID' do
        let(:id) { @member.id }

        it 'returns the correct member' do
          subject.full_name.must_equal('My Test Member')
        end
      end

      context 'local retrieval by external ID' do
        let(:id) { '5195fdb5a8c01a2318004f5d' }

        it 'returns the correct member' do
          subject.full_name.must_equal('My Test Member')
        end
      end

      context 'remote retrieval by either ID' do
        let(:id) { '526d_remote_member_005259' }
        let(:full_name) { 'My Remote Test Member' }

        before { Member.stubs(:remote).returns([@member]) }

        it 'returns the correct member' do
          subject.full_name.must_equal('My Remote Test Member')
        end
      end

      context 'when the ID cannot be found' do
        let(:id) { 'not_found_id' }

        before { Member.stubs(:remote).returns([]) }

        it { subject.must_equal(nil) }
      end
    end
  end
end
