require_relative '../../../test_helper'

module Troo
  module Decorators
    describe Board do
      let(:described_class) { Board }
      let(:default) { true }
      let(:options) { {} }

      before { @board = Fabricate(:board, default: default) }
      after  { database_cleanup }

      describe '#short' do
        subject { described_class.new(@board, options).short }

        it 'returns a one line overview of the board' do
          subject.must_equal(" * \e[34m\e[4m(1) \e[0m\e[34m\e[4mMy " \
                             "Test Board\e[0m\n")
        end

        context 'when the ansicolor option is false' do
          let(:options) { { ansicolor: false } }

          it 'returns a one line overview of the board' do
            subject.must_match(/ \* \(1\) My Test Board/)
          end
        end
      end

      describe '#name_str' do
        subject { described_class.new(@board).name_str }

        it 'returns the formatted board name' do
          subject.must_equal("\e[34m\e[4mMy Test Board\e[0m")
        end
      end

      describe '#description' do
        subject { described_class.new(@board).description }

        context 'when the board has a description' do
          it 'returns the board description' do
            subject.must_equal(@board.description)
          end
        end

        context 'when the board has no description' do
          before { @board.stubs(:description) }

          it 'returns N/A' do
            subject.must_equal('N/A')
          end
        end
      end
    end
  end
end
