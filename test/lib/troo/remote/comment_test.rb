require_relative '../../../test_helper'

module Troo
  module Remote
    describe Comment do
      let(:described_class) { Comment }
      let(:resource)        {
        mock_trello_response('comment.json', Troo::Remote::Comment)
      }
      let(:described_instance) { described_class.new(resource) }

      describe '.remote_options' do
        subject { described_class.remote_options }

        it { subject.must_be_instance_of(Hash) }

        it 'returns the default remote options' do
          subject.fetch(:mode).must_equal(:card)
        end
      end

      describe '.by_board_id' do
        subject { described_class.by_board_id }

        it { subject.must_be_instance_of(Hash) }

        it 'returns the resource parameters' do
          subject.fetch(:endpoint).must_equal(:comments_by_board_id)
        end
      end

      describe '.by_card_id' do
        subject { described_class.by_card_id }

        it { subject.must_be_instance_of(Hash) }

        it 'returns the resource parameters' do
          subject.fetch(:endpoint).must_equal(:comments_by_card_id)
        end
      end

      describe '#external_board_id' do
        subject { described_instance.external_board_id }

        it { subject.must_be_instance_of(String) }

        it 'delegates to the CommentData model' do
          subject.must_equal('20010')
        end
      end

      describe '#external_card_id' do
        subject { described_instance.external_card_id }

        it { subject.must_be_instance_of(String) }

        it 'delegates to the CommentData model' do
          subject.must_equal('20020')
        end
      end

      describe '#external_comment_id' do
        subject { described_instance.external_comment_id }

        it { subject.must_be_instance_of(String) }

        it 'returns the value of the id attribute' do
          subject.must_equal('20030')
        end
      end

      describe '#text' do
        subject { described_instance.text }

        it { subject.must_be_instance_of(String) }

        it 'delegates to the CommentData model' do
          subject.must_equal('My Test Comment')
        end
      end

      describe '#associations' do
        subject { described_instance.associations }

        it { subject.must_be_instance_of(Array) }

        it { subject.must_equal [:memberCreator] }
      end

      describe '#local_model' do
        subject { described_instance.local_model }

        it { subject.must_be_instance_of(Class) }

        it { subject.must_equal Troo::Comment }
      end

      describe '#adapted' do
        subject { described_instance.adapted }

        it { subject.must_be_instance_of(Hash) }

        it 'returns an adapted resource for local persistence' do
          subject.must_equal(
            external_id:        '20030',
            external_board_id:  '20010',
            external_card_id:   '20020',
            external_member_id: '20050',
            date:               '2014-02-07T18:02:24.297Z',
            text:               'My Test Comment'
          )
        end
      end
    end
  end
end
