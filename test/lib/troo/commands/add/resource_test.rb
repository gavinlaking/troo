require_relative '../../../../test_helper'

module Troo
  module Commands
    module Add
      describe Resource do
        let(:described_class) { Resource }
        let(:value) {}
        let(:id)    {}

        describe '#initialize' do
          subject { described_class.new(value, id) }

          it 'assigns the value to an instance variable' do
            subject.instance_variable_get('@value').must_equal(value)
          end

          it 'assigns the id to an instance variable' do
            subject.instance_variable_get('@id').must_equal(id)
          end
        end
      end
    end
  end
end
