require_relative '../../../../test_helper'

module Troo
  module Commands
    module Show
      describe List do
        let(:described_class) { List }
        let(:type) { :list }
        let(:id) { '1' }
        let(:default) { false }
        let(:resource) {}
        let(:presenter) { stub }

        before do
          @list = Fabricate.build(:list, default: default)
          Retrieval::List.stubs(:retrieve).returns(resource)
          Presenters::List.stubs(:new).returns(presenter)
          presenter.stubs(:show).returns(@list.name)
        end

        after { database_cleanup }

        describe '.dispatch' do
          subject { described_class.dispatch(type, id) }

          context 'when a resource ID is provided' do
            context 'and the resource exists' do
              let(:resource) { @list }

              it 'presents the lists' do
                subject.must_match(/#{@list.name}/)
              end
            end

            context 'but the resource does not exist' do
              it 'returns a polite message' do
                subject.must_match(/List cannot be found/)
              end
            end
          end

          context 'when a resource ID is not provided' do
            let(:id) {}

            context 'and a default resource is set' do
              let(:default) { true }
              let(:resource) { @list }

              it 'presents the lists' do
                subject.must_match(/#{@list.name}/)
              end
            end

            context 'and a default resource is not set' do
              it 'returns a polite message' do
                subject.must_match(/to set a default list first/)
              end
            end
          end
        end
      end
    end
  end
end
