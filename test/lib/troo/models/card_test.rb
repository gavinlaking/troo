require_relative '../../../test_helper'

module Troo
  describe Card do
    let(:described_class) { Card }
    let(:described_instance) { Fabricate.build(:card) }

    subject { described_instance }

    context 'attributes' do
      it 'should have a short_id attribute' do
        subject.short_id.must_equal '67'
      end

      it 'should have a name attribute' do
        subject.name.must_equal 'My Test Card'
      end

      it 'should have a desc attribute' do
        subject.desc.must_equal 'some description'
      end

      it 'should have a url attribute' do
        subject.url.must_equal 'some trello url'
      end

      describe '#external_member_ids' do
        context 'when the attribute is set' do
          context 'and the attribute is an array' do
            it 'returns the attribute' do
              subject.external_member_ids
                .must_equal(['20050'])
            end
          end

          context 'and the attribute is a string' do
            let(:member_ids)         { "[\"20050\"]" }
            let(:described_instance) {
              Fabricate.build(:card,
                              external_member_ids: member_ids)
            }

            it 'converts to an array and returns the attribute' do
              subject.external_member_ids
                .must_equal(['20050'])
            end
          end
        end

        context 'when the attribute is not set' do
          let(:described_instance) {
            Fabricate.build(:card, external_member_ids: nil)
          }

          it 'returns an empty collection' do
            subject.external_member_ids.must_equal([])
          end
        end
      end

      it 'should have a position attribute' do
        subject.position.must_equal 16
      end

      it 'should have a last_activity_date attribute' do
        subject.last_activity_date
          .must_equal '2013-12-17 21:48:09 UTC'
      end

      it 'should have a default attribute' do
        subject.default.must_equal false
      end

      it 'should have a closed attribute' do
        subject.closed.must_equal false
      end

      it 'should have an external_board_id attribute' do
        subject.external_board_id
          .must_equal '20010'
      end

      it 'should have an external_list_id attribute' do
        subject.external_list_id.must_equal '20040'
      end

      it 'should have an external_id attribute' do
        subject.external_id.must_equal '20020'
      end
    end

    describe '.remote' do
      subject { described_class.remote }

      it 'returns the remote class for this model' do
        subject.must_equal(Remote::Card)
      end
    end

    describe '.type' do
      subject { described_class.type }

      it { subject.must_be_instance_of(Symbol) }

      it 'returns the type of model' do
        subject.must_equal(:card)
      end
    end

    context 'associations' do
      before do
        @board   = Fabricate(:board)
        @list    = Fabricate(:list)
        @comment = Fabricate(:comment)
        @member  = Fabricate(:member)
      end

      after { database_cleanup }

      it 'belongs to a board' do
        subject.board.must_equal @board
      end

      it 'belongs to a list' do
        subject.list.must_equal @list
      end

      it 'can have many comments' do
        subject.comments.size.must_equal 1
      end

      it 'can have many comments' do
        subject.recent_comments.size.must_equal 1
      end

      context 'when the card has members' do
        it 'returns the collection of members' do
          subject.members.size.must_equal 1
        end
      end

      context 'when the card has no members' do
        before { subject.stubs(:external_member_ids).returns([]) }

        it 'returns an empty collection' do
          subject.members.size.must_equal 0
        end
      end
    end

    describe '#decorator' do
      let(:options) { {} }

      subject { described_class.new.decorator(options) }

      it 'returns a new instance of the decorator for this model' do
        subject.must_be_instance_of(Decorators::Resource)
      end
    end

    describe '#presenter' do
      let(:options) { {} }

      subject { described_class.new.presenter(options) }

      it 'returns a new instance of the presenter for this model' do
        subject.must_be_instance_of(Presenters::Card)
      end
    end

    describe '#comment_presenter' do
      let(:options) { {} }

      subject { described_class.new.comment_presenter(options) }

      it 'returns a new instance of the comment presenter' do
        subject.must_be_instance_of(Presenters::Comment)
      end
    end

    describe '#type' do
      subject { described_class.new.type }

      it 'returns the type of the model instance' do
        subject.must_equal(:card)
      end
    end
  end
end
