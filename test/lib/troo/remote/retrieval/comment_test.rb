require_relative '../../../../test_helper'

module Troo
  module Remote
    module Retrieval
      describe Comment do
        let(:described_class) { Comment }
        let(:external_id) { 'some_id' }
        let(:options) { {} }

        describe '.fetch' do
          subject { described_class.fetch(external_id, options) }

          context 'when the mode is :all' do
            let(:options) { { mode: :all } }

            it { subject.must_equal [] }
          end

          context 'when the mode is :board' do
            let(:external_id) { '526d8e130a14a9d846001d96' }
            let(:options) { { mode: :board } }

            before do
              VCR.insert_cassette(:comments_by_board_id,
                                  decode_compressed_response: true)
            end
            after { VCR.eject_cassette }

            it 'fetches the remote resource' do
              subject.size.must_equal(1)
            end
          end

          context 'when the mode is :list' do
            let(:options) { { mode: :list } }

            it { subject.must_equal [] }
          end

          context 'when the mode is :card' do
            let(:external_id) { '526d8f19ddb279532e005259' }
            let(:options) { { mode: :card } }

            before do
              VCR.insert_cassette(:comments_by_card_id,
                                  decode_compressed_response: true)
            end
            after { VCR.eject_cassette }

            it 'fetches the remote resource' do
              subject.size.must_equal(1)
            end
          end

          context 'when the mode is :member' do
            let(:options) { { mode: :member } }

            it { subject.must_equal [] }
          end
        end
      end
    end
  end
end
