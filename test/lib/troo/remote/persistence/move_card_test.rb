require_relative '../../../../test_helper'

module Troo
  module Remote
    module Persistence
      describe MoveCard do
        let(:described_class)   { MoveCard }
        let(:external_board_id) { '20010' }
        let(:external_card_id)  { '20020' }
        let(:external_list_id)  { '20040' }
        let(:card)              { [Fabricate.build(:card)] }

        before do
          Troo::Persistence::Local.stubs(:with_collection)
            .returns(card)
        end

        after { database_cleanup }

        describe '.with' do
          let(:board) {}

          subject do
            described_class.with(external_card_id,
                                 external_list_id,
                                 external_board_id)
          end

          context 'when a board was specified' do
            let(:board) { @board }

            before do
              VCR.insert_cassette(:move_card_board,
                                  decode_compressed_response: true)
            end

            after { VCR.eject_cassette }

            context 'and the card was moved' do
              it 'returns the updated card' do
                subject.must_be_instance_of Troo::Card
              end
            end

            context 'and the card was not moved' do
              before { API::Client.stubs(:perform).returns([]) }

              it { subject.must_equal false }
            end
          end

          context 'when a board was not specified' do
            let(:external_board_id) {}

            before do
              VCR.insert_cassette(:move_card_list,
                                  decode_compressed_response: true)
            end

            after { VCR.eject_cassette }

            context 'and the card was moved' do
              it 'returns the updated card' do
                subject.must_be_instance_of Troo::Card
              end
            end

            context 'and the card was not moved' do
              before { API::Client.stubs(:perform).returns([]) }

              it { subject.must_equal false }
            end
          end
        end
      end
    end
  end
end
