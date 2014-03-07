require_relative '../../../test_helper'

module Troo
  module Retrieval
    describe Remote do
      let(:described_class) { Remote }
      let(:klass)           { stub(remote_options: {}) }
      let(:external_id)     { '526d8e130a14a9d846001d96' }
      let(:options)         { {} }
      let(:resources)       { [:not_persisted] }
      let(:persisted)       { [:persisted] }

      before do
        API::Client.stubs(:perform).returns(resources)
        Troo::Persistence::Local.stubs(:with_collection)
          .returns(persisted)
      end

      describe '#fetch' do
        subject { described_class.fetch(klass, external_id, options) }

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
