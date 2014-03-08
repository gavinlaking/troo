require_relative '../../../../test_helper'

module Troo
  module Remote
    module Persistence
      describe Board do
        let(:described_class) { Board }
        let(:resource_name)   { 'My New Board' }
        let(:description)     { 'A very brief description...' }

        describe '.with' do
          subject { described_class.with(resource_name, description) }

          context 'when the board was created' do
            before do
              VCR.insert_cassette(:create_board,
                                  decode_compressed_response: true)
            end

            after do
              database_cleanup
              VCR.eject_cassette
            end

            it 'returns the new board' do
              subject.must_be_instance_of Troo::Board
            end
          end

          context 'when the board was not created' do
            before { API::Client.stubs(:perform).returns([]) }

            it { subject.must_equal false }
          end
        end
      end
    end
  end
end
