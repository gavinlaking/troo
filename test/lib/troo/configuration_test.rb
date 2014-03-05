require_relative '../../test_helper'

module Troo
  describe Configuration do
    let(:described_class) { Configuration }

    subject { described_class.load('test/support/.trooconf', :test) }

    context 'attributes' do
      it 'configures the API url' do
        subject.api_url.must_equal('http://www.example.com')
      end

      it 'configures the API key' do
        subject.api_key.must_equal('some_key')
      end

      it 'configures the API token' do
        subject.api_token.must_equal('some_token')
      end

      it 'configures the API OAuth token' do
        subject.api_oauth_token.must_equal('some_oauth_token')
      end

      it 'configures the API OAuth token secret' do
        subject.api_oauth_token_secret.must_equal('some_oauth_token_secret')
      end

      it 'configures the database to use' do
        subject.database.must_equal(5)
      end

      it 'configures communication with the Trello API' do
        subject.allow_remote.must_equal(true)
      end

      it 'configures log output' do
        subject.logs.must_equal(false)
      end
    end
  end
end
