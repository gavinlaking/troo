require_relative '../../../../test_helper'

module Troo
  module Commands
    module Refresh
      describe List do
        let(:described_class) { List }
        let(:id) { '1' }
        let(:resource) {}
        let(:retrieved) {}

        before do
          API::Client.stubs(:perform)
          @list = Fabricate.build(:list)
          Troo::List.stubs(:retrieve).returns(resource)
          Troo::List.stubs(:fetch).returns(retrieved)
        end

        after { database_cleanup }

        describe '.dispatch' do
          subject { described_class.dispatch(id) }

          context 'when the resource exists' do
            let(:resource) { @list }
            let(:retrieved) { [@list] }

            context 'and the resource is refreshed' do
              it 'returns a polite message' do
                subject.must_match(/refreshed/)
              end
            end

            context 'and multiple resources are refreshed' do
              let(:retrieved) { [@list, @list] }

              it 'returns a polite message' do
                subject.must_match(/Multiple/)
              end
            end
          end

          context 'when the resource does not exist' do
            let(:resource) {}

            it 'returns a polite message' do
              subject.must_match(/List cannot be found/)
            end
          end

          context 'and the default resource does not exist' do
            let(:id) {}
            let(:resource) {}

            it 'returns a polite message' do
              subject.must_match(/set a default list first/)
            end
          end
        end
      end
    end
  end
end
