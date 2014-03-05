require_relative '../../../test_helper'

module Troo
  module Decorators
    describe List do
      let(:described_class) { List }
      let(:default) { true }
      let(:options) { {} }

      before { @list = Fabricate(:list, default: default) }
      after  { database_cleanup }

      describe '#short' do
        subject { described_class.new(@list, options).short }

        it 'returns a one line overview of the list' do
          subject.must_equal(" * \e[32m\e[4m(1) \e[0m\e[32m\e[4mMy " \
                             "Test List\e[0m\n")
        end

        context 'when the ansicolor option is false' do
          let(:options) { { ansicolor: false } }

          it 'returns a one line overview of the board' do
            subject.must_match(/ \* \(1\) My Test List/)
          end
        end
      end

      describe '#name_str' do
        subject { described_class.new(@list).name_str }

        it 'returns the formatted list name' do
          subject.must_equal("\e[32m\e[4mMy Test List\e[0m")
        end
      end
    end
  end
end
