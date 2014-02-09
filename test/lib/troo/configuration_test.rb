require_relative '../../test_helper'

module Troo
  describe Configuration do
    it 'configures the API url' do
      Configuration.api_url.must_equal('https://api.trello.com/1')
    end

    it 'configures the API key' do
      Configuration.api_key.must_equal('some_key')
    end

    it 'configures the API token' do
      Configuration.api_token.must_equal('some_token')
    end

    it 'configures the main database to use' do
      Configuration.main_db.must_equal(5)
    end

    it 'configures the test database to use' do
      Configuration.test_db.must_equal(6)
    end
  end
end
