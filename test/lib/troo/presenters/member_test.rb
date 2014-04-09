require_relative '../../../test_helper'

module Troo
  module Presenters
    describe Member do
      let(:described_class)     { Member }
      let(:options)             { {} }
      let(:external_member_ids) { ['20050'] }

      before do
        @card = Fabricate(:card,
                          external_member_ids: external_member_ids)
        Fabricate(:member, username: 'hydrogen', external_id: '20051')
        Fabricate(:member, username: 'helium',   external_id: '20052')
        Fabricate(:member, username: 'lithium',  external_id: '20053')
      end

      after { database_cleanup }

      describe '#show' do
        subject { described_class.new(@card, options).show }

        context 'when there a more than 2 members' do
          let(:external_member_ids) { ['20051', '20052', '20053'] }

          it 'returns the members as a sentence' do
            subject.must_equal('@hydrogen, @helium and @lithium')
          end
        end

        context 'when there is more than 1 member' do
          let(:external_member_ids) { ['20051', '20052'] }

          it 'returns the members as a sentence' do
            subject.must_equal('@hydrogen and @helium')
          end
        end

        context 'when there is one member' do
          let(:external_member_ids) { ['20051'] }

          it 'returns the members as a sentence' do
            subject.must_equal('@hydrogen')
          end
        end

        context 'when there are no members' do
          let(:external_member_ids) { [] }

          it 'returns the members as a sentence' do
            subject.must_equal('No members have been assigned.')
          end
        end
      end
    end
  end
end
