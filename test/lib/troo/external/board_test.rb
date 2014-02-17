require_relative '../../../test_helper'

module Troo
  module External
    describe Board do
      let(:described_class) { Board }
      let(:external_id) { 'some_id' }
      let(:options) { {} }

      describe '.fetch' do
        subject { described_class.fetch(external_id, options) }

        context 'when the mode is :all' do
          let(:options) { { mode: :all } }

          before do
            VCR.insert_cassette(:boards_all,
                                decode_compressed_response: true)
          end
          after { VCR.eject_cassette }

          it 'fetches the remote resource' do
            subject.size.must_equal(1)
          end
        end

        context 'when the mode is :board' do
          let(:external_id) { '526d8e130a14a9d846001d96' }
          let(:options) { { mode: :board } }

          before do
            VCR.insert_cassette(:board_by_id,
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
          let(:options) { { mode: :member } }

          it { subject.must_equal [] }
        end
      end
    end
  end
end
