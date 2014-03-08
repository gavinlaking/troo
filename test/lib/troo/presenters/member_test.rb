require_relative '../../../test_helper'

module Troo
  module Presenters
    describe Member do
      let(:described_class)     { Member }
      let(:options)             { {} }
      let(:external_member_ids) { ['5195fdb5a8c01a2318004f5d'] }

      before do
        @card = Fabricate(:card,
                          external_member_ids: external_member_ids)
        @member = Fabricate(:member)
      end

      after { database_cleanup }

      describe '#show' do
        subject { described_class.new(@card, options).show }

        it 'returns the members as a sentence' do
          subject.must_equal('@gavinlaking1')
        end
      end
    end
  end
end
