require_relative '../../../test_helper'

module Troo
  module Decorators
    describe Card do
    #   let(:described_class)    { Card }
    #   let(:described_instance) { described_class.new(@card, options) }
    #   let(:default)            { true }
    #   let(:description)        { 'Finish Troo for fame and fortune.' }
    #   let(:options)            { {} }

    #   before do
    #     @board     = Fabricate(:board)
    #     @list      = Fabricate(:list)
    #     @card      = Fabricate(:card,
    #                            desc: description,
    #                            default: default)
    #     @comment   = Fabricate(:comment)
    #     @comment_2 = Fabricate(:comment,
    #                            text: 'My Other Test Comment')
    #     @comment_3 = Fabricate(:comment,
    #                            text: 'My Lithium Comment')
    #     @comment_4 = Fabricate(:comment,
    #                            text: 'My Beryllium Comment')
    #     @member    = Fabricate(:member)
    #     @member_2  = Fabricate(:member,
    #                            username: 'mysterywoman',
    #                            external_member_id: 'some_member_id')
    #   end

    #   after { database_cleanup }

    #   describe '#comments' do
    #     subject { described_instance.comments }

    #     context 'when there are more than 3 comments' do
    #       it 'returns the comments' do
    #         subject.must_match(/There are more comments/)
    #         subject.must_match(/My Test Comment/)
    #         subject.must_match(/My Other Test Comment/)
    #         subject.must_match(/My Lithium Comment/)
    #         subject.wont_match(/My Beryllium Comment/)
    #       end
    #     end

    #     context 'when there are 3 or less comments' do
    #       before do
    #         @comment_3.delete
    #         @comment_4.delete
    #       end

    #       it 'returns the comments' do
    #         subject.must_match(/My Test Comment/)
    #         subject.must_match(/My Other Test Comment/)
    #       end
    #     end

    #     context 'when there are no comments' do
    #       before do
    #         @comment.delete
    #         @comment_2.delete
    #         @comment_3.delete
    #         @comment_4.delete
    #       end

    #       it 'returns a polite message' do
    #         subject.must_equal('No comments have been left.')
    #       end
    #     end
    #   end

    #   describe '#members' do
    #     subject { described_instance.members }

    #     context 'when there are members' do
    #       it 'returns the members' do
    #         subject.must_equal('@gavinlaking1')
    #       end
    #     end

    #     context 'when there are no members' do
    #       before do
    #         @card.external_member_ids = nil
    #         @member.delete
    #         @member_2.delete
    #       end

    #       it 'returns a polite message' do
    #         subject.must_equal('No members have been assigned.')
    #       end
    #     end
    #   end

    #   describe '#last_activity_date' do
    #     subject { described_instance.last_activity_date }

    #     context 'when the last activity date is set' do
    #       it 'returns the last activity date' do
    #         subject.must_equal('Tue, Dec 17 at 21:48')
    #       end
    #     end

    #     context 'when the last activity date is not set' do
    #       before { @card.stubs(:last_activity_date) }

    #       it "returns 'N/A'" do
    #         subject.must_equal('N/A')
    #       end
    #     end
    #   end
    end
  end
end
