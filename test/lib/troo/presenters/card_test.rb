require_relative '../../../test_helper'

module Troo
  module Presenters
    describe Card do
      let(:described_class) { Card }
      let(:card)            { Fabricate(:card) }
      let(:options)         { {} }

      let(:output)          {
"(\e[35m\e[4m67\e[0m) My Test Card

\e[33m\e[4mDescription:\e[0m
some description

\e[33m\e[4mComments:\e[0m
No comments have been left.

\e[33m\e[4mMembers:\e[0m
@gavinlaking1

\e[33m\e[4mMetadata:\e[0m
\e[36m   Board:\e[0m (1) \e[34m\e[4mMy Test Board\e[0m
\e[36m    List:\e[0m (1) \e[32m\e[4mMy Test List\e[0m
\e[36m Updated:\e[0m Tue, Dec 17 at 21:48
"
      }

      before do
        Fabricate(:board)
        Fabricate(:list)
        Fabricate(:member)
      end

      after { database_cleanup }

      describe '#show' do
        subject { described_class.new(card, options).show }

        it 'renders the card' do
          subject.must_equal(output)
        end
      end
    end
  end
end
