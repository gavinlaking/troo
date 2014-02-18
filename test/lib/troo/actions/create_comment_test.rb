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
        before do
          Trello::Card.any_instance.stubs(:add_comment)
            .raises(Trello::Error)
        end

        it { subject.must_equal false }
      end

      context 'when the access token is invalid' do
        let(:card) { stub }

        before do
          Trello::Card.stubs(:new).returns(card)
          card.stubs(:update_fields).returns(card)
          card.stubs(:add_comment).raises(Trello::InvalidAccessToken)
        end

        subject { described_class.for(@card, comment) }

        it 'catches the exception and re-raises' do
          proc { subject }.must_raise(Troo::InvalidAccessToken)
        end
      end
    end
  end
end
