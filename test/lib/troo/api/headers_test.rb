require_relative '../../../test_helper'

module Troo
  module API
    describe Headers do
      let(:described_class) { Headers }
      let(:uri)     { 'http://www.example.com/' }
      let(:headers) { {} }

      describe '#build!' do
        subject do
          described_class.build!(uri, headers)['Authorization']
        end

        it 'returns the built headers' do
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
