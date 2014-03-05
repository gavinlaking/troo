require_relative '../../../test_helper'

module Troo
  module Decorators
    describe Resource do
      let(:described_class)    { Resource }
      let(:klass)              { stub(id: 67, name: resource_name) }
      let(:options)            { {} }
      let(:described_instance) { described_class.new(klass, options) }
      let(:resource_name)      { 'My Resource' }
      let(:default)            { true }

      before { klass.stubs(:default?).returns(default) }

      describe '#initialize' do
        subject { described_class.new(klass, options) }

        it 'assigns the klass to an instance variable' do
          subject.instance_variable_get('@klass').must_equal(klass)
        end

        it 'assigns the options to an instance variable' do
          subject.instance_variable_get('@options')
            .must_equal(options)
        end
      end

      describe '#title' do
        subject { described_instance.title }

        it { subject.must_match(/My Resource/) }
      end

      describe '#default' do
        subject { described_instance.default }

        context 'when the resource is default' do
          it 'returns a marker' do
            subject.must_equal(' * ')
          end
        end

        context 'when the resource is not the default' do
          let(:default) { false }

          it 'returns a space' do
            subject.must_equal('   ')
          end
        end
      end

      describe '#id_str' do
        subject { described_instance.id_str }

        it 'returns the formatted id' do
          subject.must_equal("(67) \e[0m")
        end
      end

      describe '#name' do
        subject { described_instance.name }

        context 'when the resource has a name' do
          let(:resource_name) { 'My Resource' }

          it { subject.must_equal('My Resource') }
        end

        context 'when the resource has a end of line character' do
          let(:resource_name) { "My Resource\n" }

          it { subject.must_equal('My Resource') }
        end

        context 'when the resource does not have a name' do
          let(:resource_name) { }

          it { subject.must_equal('N/A') }
        end
      end

      describe '#board' do
        subject { described_instance.board }

        it 'returns the board details' do
          skip
        end
      end

      describe '#list' do
        subject { described_instance.list }

        it 'returns the list details' do
          skip
        end
      end

      describe '#lists' do
        subject { described_instance.lists }

        it 'returns the lists details' do
          skip
        end
      end

      describe '#cards' do
        subject { described_instance.cards }

        it 'returns the cards details' do
          skip
        end
      end
    end
  end
end
