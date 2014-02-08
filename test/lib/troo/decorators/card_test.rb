require_relative '../../../test_helper'

module Troo
  module Decorators
    describe Card do
      let(:described_class)    { Card }
      let(:described_instance) { described_class.new(@card, options) }
      let(:default)            { true }
      let(:description)        { 'Finish Troo for fame and fortune.' }
      let(:options)            { {} }

      before do
        @board     = Fabricate(:board)
        @list      = Fabricate(:list)
        @card      = Fabricate(:card, desc: description, default: default)
        @comment   = Fabricate(:comment)
        @comment_2 = Fabricate(:comment, text: 'My Other Test Comment')
        @comment_3 = Fabricate(:comment, text: 'My Lithium Comment')
        @comment_4 = Fabricate(:comment, text: 'My Beryllium Comment')
        @member    = Fabricate(:member)
        @member_2  = Fabricate(:member, username: 'mysterywoman', external_member_id: 'some_member_id')
      end

      after { database_cleanup }

      describe '#initialize' do
        subject { described_instance }

        it 'assigns the card to an instance variable' do
          subject.instance_variable_get('@card').must_equal(@card)
        end

        it 'assigns the options to an instance variable' do
          subject.instance_variable_get('@options').must_equal(options)
        end
      end

      describe '#short' do
        subject { described_instance.short }

        it 'returns a one line overview of the card' do
          subject.must_equal(" * \e[35m\e[4m(67) \e[0m\e[35m\e[4mMy Test Card\e[0m\n")
        end

        context 'when the ansicolor option is false' do
          let(:options) { { ansicolor: false } }

          it 'returns a one line overview of the card' do
            subject.must_equal(" *  (67) My Test Card\n")
          end
        end
      end

      describe '#name_str' do
        subject { described_instance.name_str }

        it 'returns the formatted card name' do
          subject.must_equal("\e[35m\e[4mMy Test Card\e[0m")
        end
      end

      describe '#default_str' do
        subject { described_instance.default_str }

        it 'returns the formatted card default indicator' do
          subject.must_equal(' * ')
        end
      end

      describe '#id_str' do
        subject { described_instance.id_str }

        it 'returns the formatted card id' do
          subject.must_equal("\e[35m\e[4m(67) \e[0m")
        end
      end

      describe '#name' do
        subject { described_instance.name }

        it 'returns the card name' do
          subject.must_equal(@card.name)
        end
      end

      describe '#default' do
        subject { described_instance.default }

        context 'when default' do
          it 'return an indicator' do
            subject.must_equal('*')
          end
        end

        context 'when not default' do
          let(:default) { false }

          it 'returns nothing' do
            subject.must_equal('')
          end
        end
      end

      describe '#id' do
        subject { described_instance.id }

        it 'returns the card id' do
          subject.must_equal(@card.short_id)
        end
      end

      describe '#description' do
        subject { described_instance.description }

        context 'when there are further details' do
          it 'returns the description' do
            subject.must_equal(@card.desc)
          end
        end

        context 'when there are no further details' do
          let(:description) { nil }

          it 'returns a polite message' do
            subject.must_equal('There are no further details at this time.')
          end
        end
      end

      describe '#comments' do
        subject { described_instance.comments }

        context 'when there are more than 3 comments' do
          it 'returns the comments' do
            subject.must_match(/There are more comments/)
            subject.must_match(/My Test Comment/)
            subject.must_match(/My Other Test Comment/)
            subject.must_match(/My Lithium Comment/)
            subject.wont_match(/My Beryllium Comment/)
          end
        end

        context 'when there are 3 or less comments' do
          before do
            @comment_3.delete
            @comment_4.delete
          end

          it 'returns the comments' do
            subject.must_match(/My Test Comment/)
            subject.must_match(/My Other Test Comment/)
          end
        end

        context 'when there are no comments' do
          before do
            @comment.delete
            @comment_2.delete
            @comment_3.delete
            @comment_4.delete
          end

          it 'returns a polite message' do
            subject.must_equal('No comments have been left.')
          end
        end
      end

      describe '#members' do
        subject { described_instance.members }

        context 'when there are members' do
          it 'returns the members' do
            subject.must_equal('@gavinlaking1')
          end
        end

        context 'when there are no members' do
          before do
            @card.external_member_ids = nil
            @member.delete
            @member_2.delete
          end

          it 'returns a polite message' do
            subject.must_equal('No members have been assigned.')
          end
        end
      end

      describe '#last_activity_date' do
        subject { described_instance.last_activity_date }

        context 'when the last activity date is set' do
          it 'returns the last activity date' do
            subject.must_equal('Tue, Dec 17 at 21:48')
          end
        end

        context 'when the last activity date is not set' do
          before { @card.stubs(:last_activity_date) }

          it "returns 'N/A'" do
            subject.must_equal('N/A')
          end
        end
      end

      describe '#board' do
        subject { described_instance.board }

        it 'returns the board details' do
          subject.must_equal "   \e[35m\e[4m(1) \e[0m\e[35m\e[4mMy Test Board\e[0m\n"
        end
      end

      describe '#list' do
        subject { described_class.new(@card).list }

        it 'returns the list details' do
          subject.must_equal "   \e[35m\e[4m(1) \e[0m\e[35m\e[4mMy Test List\e[0m\n"
        end
      end
    end
  end
end
