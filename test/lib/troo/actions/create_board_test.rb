require_relative '../../../test_helper'

module Troo
  describe CreateBoard do
    let(:described_class) { CreateBoard }
    let(:resource_name)   { 'My New Board' }
    let(:description)     { 'A very brief description...' }

    describe '.initialize' do
      subject { described_class.new(resource_name, description) }

      it 'assigns the name to an instance variable' do
        subject.instance_variable_get('@name')
          .must_equal(resource_name)
      end

      it 'assigns the description to an instance variable' do
        subject.instance_variable_get('@description')
          .must_equal(description)
      end
    end

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
        before { API::Client.stubs(:perform).returns(false) }

        it { subject.must_equal false }
      end
    end
  end
end
