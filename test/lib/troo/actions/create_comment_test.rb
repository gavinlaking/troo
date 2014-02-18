require_relative '../../../test_helper'

module Troo
  describe CreateComment do
    let(:described_class) { CreateComment }
    let(:card_id) { '526d8f19ddb279532e005259' }
    let(:comment) { 'Some much needed feedback...' }

    before do
      API::Client.stubs(:perform)
      @card = Fabricate(:card)
      @comment = Fabricate(:comment, text: comment)
      Persistence::Comment.stubs(:for).returns(@comment)
    end

    after { database_cleanup }

    describe '.initialize' do
      subject { described_class.new(@card, comment) }

      it 'assigns the card to an instance variable' do
        subject.instance_variable_get('@card').must_equal(@card)
      end

      it 'assigns the comment to an instance variable' do
        subject.instance_variable_get('@comment').must_equal(comment)
      end
    end

    describe '.with' do
      before do
        VCR.insert_cassette(:create_comment,
                            decode_compressed_response: true)
      end

      after  { VCR.eject_cassette }

      subject { described_class.with(@card, comment) }

      context 'when the comment was created' do
        it 'returns the new comment' do
          subject.must_equal(@comment)
        end
      end

      context 'when the comment was not created' do
        before { API::Client.stubs(:perform).returns(false) }

        it { subject.must_equal false }
      end
    end
  end
end
