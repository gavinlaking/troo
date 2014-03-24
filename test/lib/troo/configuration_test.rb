require_relative '../../test_helper'

module Troo
  describe Configuration do
    let(:described_class) { Configuration }

    subject { described_class.load('config/trooconf.yml', :test) }

    context 'configures' do
      it 'the name of the configuration' do
        subject.name.must_equal('My Example Test Configuration')
      end

      it 'the API url' do
        subject.api_url.must_equal('https://api.trello.com/1')
      end

      it 'the API key' do
        subject.api_key.must_equal('some_key')
      end

      it 'the API token' do
        subject.api_token.must_equal('some_secret')
      end

      it 'the API OAuth token' do
        subject.api_oauth_token.must_equal('some_oauth_token')
      end

      it 'the API OAuth token secret' do
        subject.api_oauth_token_secret
          .must_equal('some_oauth_token_secret')
      end

      it 'the database to use' do
        subject.database.must_equal(2)
      end

      it 'communication with the Trello API' do
        subject.allow_remote.must_equal(true)
      end

      it 'log output' do
        subject.logs.must_equal(true)
      end
    end
  end
end
