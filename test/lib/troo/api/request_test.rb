require_relative '../../../test_helper'

module Troo
  module API
    describe Request do
      let(:described_class) { Request }
      let(:urn)   { '' }
      let(:query) { {} }

      describe '#initialize' do
        subject { described_class.new(urn, query) }

        it 'assigns the urn to an instance variable' do
          subject.instance_variable_get('@urn').must_equal(urn)
        end

        it 'assigns the query to an instance variable' do
          subject.instance_variable_get('@query').must_equal(query)
        end
      end
    end
  end
end
