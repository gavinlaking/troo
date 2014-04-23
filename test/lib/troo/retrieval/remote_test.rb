require_relative '../../../test_helper'

module Troo
  module Retrieval
    describe Remote do
      let(:described_class) { Remote }
      let(:klass)           do
        stub('klass', all:            {},
                      by_board_id:    {},
                      by_list_id:     {},
                      by_card_id:     {},
                      by_member_id:   {})
      end
      let(:external_id)     { '20010' }
      let(:options)         { { mode: :board } }
      let(:resources)       { [:not_persisted] }
      let(:persisted)       { [:persisted] }

      before do
        klass.stubs(:remote_options).returns({})
        API::Client.stubs(:perform).returns(resources)
        Troo::Persistence::Local.stubs(:with_collection)
          .returns(persisted)
      end

      subject { described_class.new(klass, external_id, options) }

      it { subject.must_be_instance_of(Troo::Retrieval::Remote) }

      describe '#fetch' do
        subject { described_class.fetch(klass, external_id, options) }

        it { subject.must_be_instance_of(Array) }

        context 'when no resources were retrieved' do
          let(:resources) { [] }

          it { subject.must_equal [] }
        end

        context 'when resources were retrieved' do
          context 'and persistence is allowed' do
            it { subject.must_equal [:persisted] }
          end

          context 'and persistence is not allowed' do
            let(:options) { { persist: false } }

            it { subject.must_equal [:not_persisted] }
          end
        end
      end
    end
  end
end
