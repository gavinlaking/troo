$: << File.expand_path(File.dirname(__FILE__) + "/../lib")

require_relative 'troo/troo'
require_relative 'troo/version'

module Troo
  InvalidAccessToken = Class.new(StandardError)
  GenericAPIError    = Class.new(StandardError)

  def self.configuration(file = Dir.home + '/.trooconf', env = :default)
    @configuration ||= Troo::Configuration.load(file, env)
  end
  configuration

  def self.logger
    @logger ||= Logger.new('logs/troo.log')
  end

  # RestClient.log = 'logs/restclient.log'
  # Trello.logger = Logger.new("logs/trello.log")
  Trello.configure do |trello|
    trello.consumer_key       = Troo.configuration.api_key
    trello.consumer_secret    = Troo.configuration.api_token
    trello.oauth_token        = Troo.configuration.api_oauth_token
    trello.oauth_token_secret = Troo.configuration.api_oauth_token_secret
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
