require_relative '../../../test_helper'

module Troo
  module Decorators
    describe List do
      let(:described_class) { List }
      let(:default) { true }
      let(:options) { {} }

      before { @list = Fabricate(:list, default: default) }
      after  { database_cleanup }

      describe '#initialize' do
        subject { described_class.new(@list, options) }

        it 'assigns the list to an instance variable' do
          subject.instance_variable_get('@list').must_equal(@list)
        end

        it 'assigns the options to an instance variable' do
          subject.instance_variable_get('@options')
            .must_equal(options)
        end
      end

      describe '#short' do
        subject { described_class.new(@list, options).short }

        it 'returns a one line overview of the list' do
          subject.must_equal(" * \e[32m\e[4m(1) \e[0m\e[32m\e[4mMy " \
                             "Test List\e[0m\n")
        end

        context 'when the ansicolor option is false' do
          let(:options) { { ansicolor: false } }

          it 'returns a one line overview of the board' do
            subject.must_equal(" *   (1) My Test List\n")
          end
        end
      end

      describe '#name_str' do
        subject { described_class.new(@list).name_str }

        it 'returns the formatted list name' do
          subject.must_equal("\e[32m\e[4mMy Test List\e[0m")
        end
      end

      describe '#default_str' do
        subject { described_class.new(@list).default_str }

        it 'returns the formatted card default indicator' do
          subject.must_equal(' * ')
        end
      end

      describe '#id_str' do
        subject { described_class.new(@list).id_str }

        it 'returns the formatted list id' do
          subject.must_equal("\e[32m\e[4m(1) \e[0m")
        end
      end

      describe '#name' do
        subject { described_class.new(@list).name }

        it 'returns the list name' do
          subject.must_equal(@list.name)
        end
      end

      describe '#default' do
        subject { described_class.new(@list).default }

        context 'when default' do
          it 'return an indicator' do
            subject.must_equal('*')
          end
        end

        context 'when not default' do
          let(:default) { false }

          it 'returns nothing' do
            subject.must_equal('')
          end
        end
      end

      describe '#id' do
        subject { described_class.new(@list).id }

        it 'returns the list id' do
          subject.must_equal(@list.id.to_s)
        end
      end
    end
  end
end
