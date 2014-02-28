require_relative '../../../../test_helper'

module Troo
  module Remote
    module Persistence
      describe MoveCard do
        let(:described_class)   { MoveCard }
        let(:external_board_id) { '526d8e130a14a9d846001d96' }
        let(:external_card_id)  { '526d8f19ddb279532e005259' }
        let(:external_list_id)  { '526d8e130a14a9d846001d97' }
        let(:card)              { [Fabricate.build(:card)] }

        before do
          Troo::Persistence::Resource.stubs(:with_collection)
            .returns(card)
        end

        after { database_cleanup }

        describe '.initialize' do
          subject do
            described_class.new(external_card_id,
                                external_list_id,
                                external_board_id)
          end

          it 'assigns the external_card_id to an instance variable' do
            subject.instance_variable_get('@external_card_id')
              .must_equal(external_card_id)
          end

          it 'assigns the external_list_id to an instance variable' do
            subject.instance_variable_get('@external_list_id')
              .must_equal(external_list_id)
          end

          it 'assigns the external_board to an instance variable' do
            subject.instance_variable_get('@external_board_id')
              .must_equal(external_board_id)
          end
        end

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
