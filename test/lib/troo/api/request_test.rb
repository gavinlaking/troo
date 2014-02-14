require_relative '../../../test_helper'

module Troo
  module API
    describe Request do
      let(:described_class) { Request }
      let(:verb)  { :get }
      let(:urn)   { '' }
      let(:query) { {} }

      before do
        RestClient::Request.stubs(:execute)
      end

      describe '#initialize' do
        subject { described_class.new(verb, urn, query) }

        it 'assigns the verb to an instance variable' do
          subject.instance_variable_get('@verb').must_equal(verb)
        end

        it 'assigns the urn to an instance variable' do
          subject.instance_variable_get('@urn').must_equal(urn)
        end

        it 'assigns the query to an instance variable' do
          subject.instance_variable_get('@query').must_equal(query)
        end
      end

      describe "#response" do
        subject { described_class.new(verb, urn, query) }
      end
    end
  end
end
