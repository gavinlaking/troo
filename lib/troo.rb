require_relative "troo/troo"
require_relative "troo/version"

module Troo
  class InvalidAccessToken < StandardError; end

  def self.config
    @config ||= OpenStruct.new(YAML.load_file(Dir.home + "/.trooconf"))
  rescue Errno::ENOENT
    warn "No configuration file found..."
    src = File.dirname(__FILE__) + "/../configuration.yml.example"
    dst = Dir.home + "/.trooconf"
    FileUtils.cp(src, dst)
    warn "New configuration file created at '#{Dir.home}/.trooconf'"
    exit!
  end

  def self.logger
    @logger ||= Logger.new("logs/troo.log")
  end

  # Trello.logger = Logger.new("logs/trello.log")
  Trello.configure do |trello|
    trello.consumer_key       = config.key
    trello.consumer_secret    = config.secret
    trello.oauth_token        = config.oauth_token
    trello.oauth_token_secret = config.oauth_token_secret
  end

  class Launcher
    def initialize(argv, stdin=STDIN, stdout=STDOUT, stderr=STDERR, kernel=Kernel)
      @argv, @stdin, @stdout, @stderr, @kernel = argv, stdin, stdout, stderr, kernel
    end

    def execute!
      $stdin  = @stdin
      $stdout = @stdout

      puts
      Troo::CLI::Main.start(argv)
      puts

      @kernel.exit(0)
    rescue Troo::InvalidAccessToken
      @stderr.puts "Your Trello access credentials have expired, please renew and try again."
      @kernel.exit(1)
    rescue SocketError
      @stderr.puts "Cannot continue, no network connection."
      @kernel.exit(1)
    end

    def argv
      if @argv.include?("--test")
        @argv = @argv.delete_if { |arg| arg == "--test" }
        Ohm.connect(db: Troo.config.test_db)
      else
        Ohm.connect(db: Troo.config.main_db)
      end
      @argv
    end
  end
end
