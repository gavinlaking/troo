require_relative '../../../test_helper'

module Troo
  module API
    describe Headers do
      let(:described_class) { Headers }
      let(:uri)     { 'http://www.example.com/' }
      let(:headers) { {} }

      describe '#initialize' do
        subject { described_class.new(uri, headers) }

        it 'assigns the uri to an instance variable' do
          subject.instance_variable_get('@uri').must_equal(uri)
        end

        it 'assigns the headers to an instance variable' do
          subject.instance_variable_get('@headers').must_equal(headers)
        end
      end

      describe "#build!" do
        subject do
          described_class.build!(uri, headers)["Authorization"]
        end

        it "returns the built headers" do
          subject.must_match(/consumer_key/)
          subject.must_match(/nonce/)
          subject.must_match(/signature/)
          subject.must_match(/HMAC-SHA1/)
          subject.must_match(/timestamp/)
          subject.must_match(/token/)
          subject.must_match(/version/)
        end
      end
    end
  end
end
