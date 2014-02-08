require_relative '../../../test_helper'

class CommandHelpersDummy
  include Troo::CommandHelpers

  def initialize(type, id)
    @type, @id = type, id
  end

  private
  attr_accessor :type
end

module Troo
  describe CommandHelpers do
    let(:described_class)    { CommandHelpersDummy }
    let(:described_instance) { described_class.new(type, id) }
    let(:type)               { :board }
    let(:id)                 { nil }

    describe '#error_no_default' do
      subject { described_instance.error_no_default }

      context 'when the type is comments' do
        let(:type) { :comments }

        it 'returns the no default set error message' do
          subject.must_match /to set a default card first/
        end
      end

      context 'when the type is not comments' do
        it 'returns the no default set error message' do
          subject.must_match /to set a default board first/
        end
      end
    end

    describe '#error_not_found' do
      subject { described_instance.error_not_found }

      context 'when the type is comments' do
        let(:type) { :comments }

        it 'returns the not found error message' do
          subject.must_match /Card cannot be found/
        end
      end

      context 'when the type is not comments' do
        it 'returns the no default set error message' do
          subject.must_match /Board cannot be found/
        end
      end
    end

    describe '#type_str' do
      subject { described_instance.type_str }

      it 'returns the type as a string' do
        subject.must_equal('board')
      end
    end

    describe '#type_capitalize' do
      subject { described_instance.type_capitalize }

      it 'returns the type as a capitalized string' do
        subject.must_equal('Board')
      end
    end

    describe '#type_pluralize' do
      subject { described_instance.type_pluralize }

      it 'returns the type as a pluralized string' do
        subject.must_equal('boards')
      end
    end
  end
end
