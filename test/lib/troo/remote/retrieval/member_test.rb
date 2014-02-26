require_relative '../../../../test_helper'

module Troo
  module Remote
    module Retrieval
      describe Member do
        let(:described_class) { Member }
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
              VCR.insert_cassette(:members_by_board_id,
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
            let(:options) { { mode: :card } }

            it { subject.must_equal [] }
          end

          context 'when the mode is :member' do
            let(:external_id) { '5195fdb5a8c01a2318004f5d' }
            let(:options) { { mode: :member } }

            before do
              VCR.insert_cassette(:member_by_id,
                                  decode_compressed_response: true)
            end
            after { VCR.eject_cassette }

            it 'fetches the remote resource' do
              subject.size.must_equal(1)
            end
          end
        end
      end
    end
  end
end
