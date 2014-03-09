require_relative '../../../../../test_helper'

module Troo
  module Commands
    describe ShowComments do
      let(:described_class) { ShowComments }
      let(:type) { :comments }
      let(:id) { '1' }
      let(:default) { false }
      let(:resource) {}
      let(:presenter) { stub }

      before do
        API::Client.stubs(:perform)
        @card = Fabricate.build(:card, default: default)
        Troo::Card.stubs(:retrieve).returns(resource)
        Presenters::Comment.stubs(:new).returns(presenter)
        presenter.stubs(:show).returns(@card.name)
      end

      after { database_cleanup }

      describe '.dispatch' do
        subject { described_class.dispatch(id) }

        context 'when a resource ID is provided' do
          context 'and the resource exists' do
            let(:resource) { @card }

            it 'presents the comments' do
              subject.must_match(/#{@card.name}/)
            end
          end

          context 'but the resource does not exist' do
            it 'returns a polite message' do
              subject.must_match(/Card cannot be found/)
            end
          end
        end

        context 'when a resource ID is not provided' do
          let(:id) {}

          context 'and a default resource is set' do
            let(:default) { true }
            let(:resource) { @card }

            it 'presents the comments' do
              subject.must_match(/#{@card.name}/)
            end
          end

          context 'and a default resource is not set' do
            it 'returns a polite message' do
              subject.must_match(/to set a default card first/)
            end
          end
        end
      end
    end
  end
end
