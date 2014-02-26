require_relative '../../../test_helper'

module Troo
  describe CreateComment do
    let(:described_class)  { CreateComment }
    let(:external_card_id) { '526d8f19ddb279532e005259' }
    let(:text)             { 'Some much needed feedback...' }
    let(:comment)          { [Fabricate.build(:comment, text: text)] }

    before do
      Persistence::Resource.stubs(:with_collection).returns(comment)
    end
    after { database_cleanup }

    describe '.initialize' do
      subject { described_class.new(external_card_id, text) }

      it 'assigns the external_card_id to an instance variable' do
        subject.instance_variable_get('@external_card_id')
          .must_equal(external_card_id)
      end

      it 'assigns the comment to an instance variable' do
        subject.instance_variable_get('@comment').must_equal(text)
      end
    end

    describe '.with' do
      before do
        VCR.insert_cassette(:create_comment,
                            decode_compressed_response: true)
      end

      after  { VCR.eject_cassette }

      subject { described_class.with(external_card_id, text) }

      context 'when the comment was created' do
        it 'returns the new comment' do
          subject.must_be_instance_of Troo::Comment
        end
      end

      context 'when the comment was not created' do
        before { API::Client.stubs(:perform).returns([]) }

        it { subject.must_equal false }
      end
    end
  end
end
