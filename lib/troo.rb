$LOAD_PATH << File.expand_path(File.dirname(__FILE__) + '/../lib')

require_relative 'troo/troo'
require_relative 'troo/version'

module Troo
  InvalidAccessToken = Class.new(StandardError)
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

  Ohm.connect(db: Troo.configuration.database)

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
      pad { Troo::CLI::Main.start(@argv) }
      @kernel.exit(0)
    rescue Troo::InvalidAccessToken
      @stderr.puts 'Your Trello access credentials have expired ' \
                   'or are invalid, please renew and try again.'
      @kernel.exit(1)
    ensure
      $stdin, $stdout, $stderr = STDIN, STDOUT, STDERR
    end

    private

    def pad
      puts
      yield
      puts
    end
  end
end
