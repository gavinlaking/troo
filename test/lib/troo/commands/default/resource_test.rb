require_relative '../../../../test_helper'

module Troo
  module Commands
    module Default
      describe Resource do
        let(:described_class) { Resource }
        let(:id)    {}

        describe '#initialize' do
          subject { described_class.new(id) }

          it 'assigns the id to an instance variable' do
            subject.instance_variable_get('@id').must_equal(id)
          end
        end
      end
    end
  end
end
