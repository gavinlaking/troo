require_relative '../../../../test_helper'

module Troo
  module Commands
    module Add
      describe Board do
        let(:described_class) { Board }
        let(:value) { 'Add Board Test' }
        let(:id)    {}

        before do
          API::Client.stubs(:perform)
          CreateBoard.stubs(:with).returns(false)
        end

        describe '#add' do
          subject { described_class.new(value, id).add }

          context 'when the parent resource exists' do
            context 'and the board was created' do
              before { CreateBoard.stubs(:with).returns(true) }

              it 'returns a polite message' do
                subject.must_match(/\'Add Board Test\' created/)
              end
            end

            context 'and the board was not created' do
              it 'returns a polite message' do
                subject.must_match(/could not/)
              end
            end
          end

          context 'when the parent resource does not exist' do
            it 'returns a polite message' do
              subject.must_match(/could not/)
            end
          end
        end
      end
    end
  end
end
