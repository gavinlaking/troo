require_relative '../../../../test_helper'

module Troo
  module Commands
    module Refresh
      describe Card do
        let(:described_class) { Card }
        let(:id) { '1' }
        let(:resource) {}
        let(:retrieved) {}

        before do
          @card = Fabricate.build(:card)
          Troo::Card.stubs(:retrieve).returns(resource)
          Card.stubs(:remote).returns(retrieved)
        end

        after { database_cleanup }

        describe '.dispatch' do
          subject { described_class.dispatch(id) }

          context 'when the resource exists' do
            let(:resource) { @card }
            let(:retrieved) { [@card] }

            context 'and the resource is refreshed' do
              it 'returns a polite message' do
                subject.must_match(/refreshed/)
              end
            end

            context 'and multiple resources are refreshed' do
              let(:retrieved) { [@card, @card] }

              it 'returns a polite message' do
                subject.must_match(/Multiple/)
              end
            end
          end

          context 'when the resource does not exist' do
            let(:resource) {}

            it 'returns a polite message' do
              subject.must_match(/Card cannot be found/)
            end
          end

          context 'and the default resource does not exist' do
            let(:id) {}
            let(:resource) {}

            it 'returns a polite message' do
              subject.must_match(/Default card cannot be found/)
            end
          end
        end
      end
    end
  end
end
