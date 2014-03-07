require_relative '../../../test_helper'

module Troo
  module Presenters
    describe Card do
      let(:described_class) { Card }
      let(:options) { {} }

      before do
        @card   = Fabricate(:card)
        @board  = Fabricate(:board)
        @list   = Fabricate(:list)
        @member = Fabricate(:member)
      end

      after { database_cleanup }

      describe '#show' do
        subject { capture_io { described_class.show(@card, options) }.join }

        it 'renders the view' do
          subject.must_match(/My Test Card/)
          subject.must_match(/No comments have been left/)
          subject.must_match(/Metadata/)
        end
      end
    end
  end
end
