require_relative '../../../../test_helper'

module Troo
  module Commands
    module Status
      describe Card do
        let(:described_class) { Card }
        let(:default) { true }

        describe '.dispatch' do
          subject { described_class.dispatch }

          before { @card = Fabricate(:card, default: default) }
          after  { database_cleanup }

          context 'when a default is set' do
            it 'returns a polite message' do
              subject.must_match(/1 card found/)
            end
          end

          context 'when no default is set' do
            let(:default) { false }

            context 'and the resource exist' do
              it 'returns a polite message' do
                subject.must_match(/No default card set/)
              end
            end

            context 'and no resources exist' do
              before { Troo::Card.stubs(:count).returns(0) }

              it 'returns a polite message' do
                subject.must_match(/No cards found/)
              end
            end
          end
        end
      end
    end
  end
end
