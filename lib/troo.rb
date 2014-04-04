$LOAD_PATH << File.expand_path(File.dirname(__FILE__) + '/../lib')

require_relative 'troo/troo'
require_relative 'troo/version'

module Troo
  ConfigurationNotFound = Class.new(StandardError)
  InvalidAccessToken    = Class.new(StandardError)
  EndpointNotFound      = Class.new(StandardError)

  def self.configuration(file = Dir.home + '/.trooconf', env = :default)
    unless File.exist?(file)
      warn "\nConfiguration cannot be found, please run 'troo " \
           "init' first.\n"
      file = File.dirname(__FILE__) + '/../config/trooconf.yml'
    end

    @configuration ||= Troo::Configuration.load(file, env)
  end

  def self.endpoints(version = :version_1)
    @endpoints ||= Troo::API::Endpoints
      .load(File.dirname(__FILE__) + '/../config/trello_api.yml', version)
  end

  def self.logger
    @logger ||= Logger
      .new(File.dirname(__FILE__) + '/../logs/troo.log').tap do |log|
      log.formatter = proc do |mode, time, prog, msg|
        "#{time.iso8601} #{mode}:\n#{msg}\n\n"
      end
    end
  end

  # RestClient.log = File.dirname(__FILE__) + '/../logs/restclient.log'

  Database.connect(configuration)

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
    rescue Redis::CannotConnectError
      pad { puts 'Cannot connect to Redis database.' }
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
