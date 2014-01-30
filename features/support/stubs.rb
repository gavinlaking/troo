require_relative 'stubs/add'
require_relative 'stubs/generic'
require_relative 'stubs/refresh'
require_relative 'stubs/retrieval'
require_relative 'stubs/show'

module Stubs
  include Add
  include Generic
  include Refresh
  include Retrieval
  include Show

  def reader(location, file)
    File.read(File.dirname(__FILE__) + "/fixtures/#{location}/#{file}")
  end

  def fixture(type, filename)
    reader(type, filename)
  end

  def headers
    {
      "Accept"        => "application/json",
      "Authorization" => 'Token token="foo"',
      #"Authorization" => 'oauth_signature="1Boj4fo6KiXA4xGD%2BKF5QOD36PI%3D"',
      "User-Agent"    => "Ruby"
    }
  end

  def url
    "https://api.trello.com/1"
  end
end
