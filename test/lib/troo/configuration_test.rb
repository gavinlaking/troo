require_relative '../../test_helper'

module Troo
  describe Configuration do
    let(:described_class) { Configuration }

    subject { described_class }

    it 'configures the API url' do
      subject.api_url.must_equal('https://api.trello.com/1')
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

    it 'configures the main database to use' do
      subject.main_db.must_equal(5)
    end

    it 'configures the test database to use' do
      subject.test_db.must_equal(6)
    end
  end
end
