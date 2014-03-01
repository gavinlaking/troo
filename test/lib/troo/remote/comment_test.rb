require_relative '../../../test_helper'

module Troo
  module Remote
    describe Comment do
      def load_mock_trello_response
        json = File.read('./test/support/remotes/comment.json')
        hash = Yajl::Parser.parse(json)
      end

      let(:described_class) { Comment }
      let(:resource) { load_mock_trello_response }
      let(:described_instance) { described_class.new(resource) }

      describe '.remote_options' do
        subject { described_class.remote_options }

        it 'returns the default remote options' do
          subject.fetch(:mode).must_equal(:card)
        end
      end

      describe '.by_board_id' do
        subject { described_class.by_board_id }

        it 'returns the resource parameters' do
          subject.fetch(:endpoint).must_equal(:comments_by_board_id)
        end
      end

      describe '.by_card_id' do
        subject { described_class.by_card_id }

        it 'returns the resource parameters' do
          subject.fetch(:endpoint).must_equal(:comments_by_card_id)
        end
      end

      describe '#external_board_id' do
        subject { described_instance.external_board_id }

        it 'delegates to the CommentData model' do
          subject.must_equal('526d8e130a14a9d846001d96')
        end
      end

      describe '#external_card_id' do
        subject { described_instance.external_card_id }

        it 'delegates to the CommentData model' do
          subject.must_equal('526d8f19ddb279532e005259')
        end
      end

      describe '#external_comment_id' do
        subject { described_instance.external_comment_id }

        it 'returns the value of the id attribute' do
          subject.must_equal('51f9277b2822b8654f0023af')
        end
      end

      describe '#text' do
        subject { described_instance.text }

        it 'delegates to the CommentData model' do
          subject.must_equal('My Test Comment')
        end
      end

      describe '#associations' do
        subject { described_instance.associations }

        it { subject.must_equal [:memberCreator] }
      end

      describe '#local_model' do
        subject { described_instance.local_model }

        it { subject.must_equal Troo::Comment }
      end

      describe '#adaptor' do
        subject { described_instance.adaptor }

        it { subject.must_equal Adaptors::Comment }
      end
    end
  end
end
