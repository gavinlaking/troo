require_relative '../../../../test_helper'

module Troo
  module Commands
    module Show
      describe Resource do
        let(:described_class) { Resource }
        let(:type) {}
        let(:id)   {}

        describe '#initialize' do
          subject { described_class.new(type, id) }

          it 'assigns the type to an instance variable' do
            subject.instance_variable_get('@type').must_equal(type)
          end

          it 'assigns the id to an instance variable' do
            subject.instance_variable_get('@id').must_equal(id)
          end
        end
      end
    end
  end
end
