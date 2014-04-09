require_relative '../../../test_helper'

module Troo
  module Presenters
    describe Resource do
      let(:described_class) { Resource }
      let(:klass)           {
        stub('klass', id:       '27',
                      short_id: '66',
                      name:     'My Resource',
                      type:     type,
                      default?: default)
      }
      let(:options) { {} }
      let(:default) { false }

      describe '.list_view' do
        subject { described_class.list_view(klass, options) }

        context 'when the klass is a board' do
          let(:type) { :board }

          context 'and the resource is the default' do
            let(:default) { true }

            it 'returns a formatted string' do
              subject
                .must_equal("(27) \e[34m\e[4mMy Resource\e[0m *\n")
            end
          end

          context 'but the resource is not the default' do
            it 'returns a formatted string' do
              subject.must_equal("(27) \e[34m\e[4mMy Resource\e[0m\n")
            end
          end
        end

        context 'when the klass is a card' do
          let(:type) { :card }

          context 'and the resource is the default' do
            let(:default) { true }

            it 'returns a formatted string' do
              subject
                .must_equal("(\e[35m\e[4m66\e[0m) My Resource *\n")
            end
          end

          context 'but the resource is not the default' do
            it 'returns a formatted string' do
              subject.must_equal("(\e[35m\e[4m66\e[0m) My Resource\n")
            end
          end
        end

        context 'when the klass is a list' do
          let(:type) { :list }

          context 'and the resource is the default' do
            let(:default) { true }

            it 'returns a formatted string' do
              subject
                .must_equal("(27) \e[32m\e[4mMy Resource\e[0m *\n")
            end
          end

          context 'but the resource is not the default' do
            it 'returns a formatted string' do
              subject.must_equal("(27) \e[32m\e[4mMy Resource\e[0m\n")
            end
          end
        end
      end
    end
  end
end
