require_relative 'troo/troo'
require_relative 'troo/version'

module Troo
  InvalidAccessToken = Class.new(StandardError)
  GenericAPIError    = Class.new(StandardError)

  Troo::Configuration.load(Dir.home + '/.trooconf', :default)

  def self.logger
    @logger ||= Logger.new('logs/troo.log')
  end

  # RestClient.log = 'logs/restclient.log'
  # Trello.logger = Logger.new("logs/trello.log")
  Trello.configure do |trello|
    trello.consumer_key       = Troo::Configuration.api_key
    trello.consumer_secret    = Troo::Configuration.api_token
    trello.oauth_token        = Troo::Configuration.api_oauth_token
    trello.oauth_token_secret = Troo::Configuration.api_oauth_token_secret
  end

  class Launcher
    def initialize(argv, stdin = STDIN,
                         stdout = STDOUT,
                         stderr = STDERR,
                         kernel = Kernel)
      @argv = argv
      @stdin = stdin
      @stdout = stdout
      @stderr = stderr
      @kernel = kernel
    end

    def execute!
      $stdin, $stdout, $stderr = @stdin, @stdout, @stderr

      puts
      Troo::CLI::Main.start(@argv)
      puts

      @kernel.exit(0)
    rescue Troo::InvalidAccessToken
      @stderr.puts 'Your Trello access credentials have expired, ' \
                   ' please renew and try again.'
      @kernel.exit(1)
    rescue SocketError
      @stderr.puts 'Cannot continue, no network connection.'
      @kernel.exit(1)
    end
  end
end
