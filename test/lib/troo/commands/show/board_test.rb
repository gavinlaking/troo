require_relative '../../../../test_helper'
require 'thor'

module Troo
  module Commands
    module Show
      describe Board do
        let(:described_class) { Board }
        let(:type) { :board }
        let(:id) { '1' }
        let(:default) { false }
        let(:resource) {}
        let(:presenter) { stub }

        before do
          @board = Fabricate.build(:board, default: default)
          Troo::Board.stubs(:retrieve).returns(resource)
          Presenters::Board.stubs(:new).returns(presenter)
          presenter.stubs(:show).returns(@board.name)
        end

        after { database_cleanup }

        describe '.dispatch' do
          subject { described_class.dispatch(type, id) }

          context 'when a resource ID is provided' do
            context 'and the resource exists' do
              let(:resource) { @board }

              it 'presents the board' do
                subject.must_match(/#{@board.name}/)
              end
            end

            context 'but the resource does not exist' do
              it 'returns a polite message' do
                subject.must_match(/Board cannot be found/)
              end
            end
          end

          context 'when a resource ID is not provided' do
            let(:id) {}

            context 'and a default resource is set' do
              let(:default) { true }
              let(:resource) { @board }

              it 'presents the board' do
                subject.must_match(/#{@board.name}/)
              end
            end

            context 'and a default resource is not set' do
              it 'returns a polite message' do
                subject.must_match(/to set a default board first/)
              end
            end
          end
        end
      end
    end
  end
end
