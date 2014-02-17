$LOAD_PATH << File.expand_path(File.dirname(__FILE__) + '/../lib')

require_relative 'troo/troo'
require_relative 'troo/version'

module Troo
  InvalidAccessToken = Class.new(StandardError)
  GenericAPIError    = Class.new(StandardError)
  EndpointNotFound   = Class.new(StandardError)

  def self.configuration(file = Dir.home + '/.trooconf', env = :default)
    @configuration ||= Troo::Configuration.load(file, env)
  end
  configuration

  def self.endpoints(version = :version_1)
    @endpoints ||= Troo::API::Endpoints
      .load(File.dirname(__FILE__) + '/../config/trello_api.yml', version)
  end
  endpoints

  def self.logger
    @logger ||= Logger.new('logs/troo.log')
  end

  # RestClient.log = File.dirname(__FILE__) + '/../logs/restclient.log'

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
