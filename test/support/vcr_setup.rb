require 'vcr'

VCR.configure do |c|
  c.cassette_library_dir = 'test/cassettes'
  c.hook_into :webmock
  # c.debug_logger = File.open("logs/vcr.log", 'w')
  c.filter_sensitive_data('<OAuth Credentials>') do |interaction|
    interaction.request.headers['Authorization'].first
  end

  # Couldn't work out how to instruct VCR to filter urls, shortUrls
  # and shortLinks from the returned body string; hate myself.
  c.filter_sensitive_data('<Trello URL>') do |interaction|
    parsed = JSON.parse(interaction.response.body)
    if parsed.is_a?(Array)
      parsed.map do |hash|
        hash.map do |k, v|
          hash[k] = '<Trello URL>' if k == 'url'      ||
                                      k == 'shortUrl' ||
                                      k == 'shortLink'
        end
      end
      interaction.response.body = JSON.dump(parsed)
    elsif parsed.is_a?(Hash)
      parsed.map do |k, v|
        parsed[k] = '<Trello URL>' if k == 'url'      ||
                                      k == 'shortUrl' ||
                                      k == 'shortLink'
      end
      interaction.response.body = JSON.dump(parsed)
    end
    nil
  end
end
