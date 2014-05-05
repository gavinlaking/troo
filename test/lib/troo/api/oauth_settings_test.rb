require_relative '../../../test_helper'

module Troo
  module API
    describe OAuthSettings do
      let(:described_class) { OAuthSettings }
      let(:parameters) { {} }

      subject { described_class.new(parameters) }

      it { subject.must_be_instance_of(Troo::API::OAuthSettings) }

      context 'when no parameters are provided, uses the defaults' do
        it { subject.scheme.must_equal(:header) }

        it { subject.http_method.must_equal(:get) }

        it { subject.signature_method.must_equal('HMAC-SHA1') }

        it { subject.scope.must_equal('read,write,account') }

        it { subject.uri.must_equal(nil) }

        it { subject.request_token_path.must_equal('https://trello.com/1/OAuthGetRequestToken') }

        it { subject.authorize_path.must_equal('https://trello.com/1/OAuthAuthorizeToken') }

        it { subject.access_token_path.must_equal('https://trello.com/1/OAuthGetAccessToken') }
      end

      context 'when parameters are provided, uses provided' do
        let(:parameters) {
          {
            scheme:             :header,
            http_method:        :post,
            signature_method:   'SECURITY',
            scope:              'read,write',
            uri:                'http://www.example.com',
            request_token_path: 'http://www.example.com/request_token_path',
            authorize_path:     'http://www.example.com/authorize_path',
            access_token_path:  'http://www.example.com/access_token_path'

          }
        }

        it { subject.scheme.must_equal(:header) }

        it { subject.http_method.must_equal(:post) }

        it { subject.signature_method.must_equal('SECURITY') }

        it { subject.scope.must_equal('read,write') }

        it { subject.uri.must_equal('http://www.example.com') }

        it { subject.request_token_path.must_equal('http://www.example.com/request_token_path') }

        it { subject.authorize_path.must_equal('http://www.example.com/authorize_path') }

        it { subject.access_token_path.must_equal('http://www.example.com/access_token_path') }
      end
    end
  end
end
