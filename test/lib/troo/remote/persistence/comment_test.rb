require_relative '../../../../test_helper'

module Troo
  module Remote
    module Persistence
      describe Comment do
        let(:described_class)  { Comment }
        let(:external_card_id) { '20020' }
        let(:text)             { 'Some much needed feedback...' }
        let(:comment) do
          [Fabricate.build(:comment, text: text)]
        end

        before do
          Troo::Persistence::Local.stubs(:with_collection)
            .returns(comment)
        end
        after { database_cleanup }

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
  end
end
