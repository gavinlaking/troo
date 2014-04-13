module Troo
  class Launcher
    # @param  [Array]
    # @param  []
    # @param  []
    # @param  []
    # @param  []
    # @return []
    def initialize(argv, stdin = STDIN,
                         stdout = STDOUT,
                         stderr = STDERR,
                         kernel = Kernel)
      @argv      = argv
      @stdin     = stdin
      @stdout    = stdout
      @stderr    = stderr
      @kernel    = kernel
      @exit_code = 1
    end

    # @return [String, NilClass]
    def execute!
      $stdin, $stdout, $stderr = @stdin, @stdout, @stderr
      pad { Troo::CLI::Main.start(@argv) }
      exit_code = 0
    rescue Errno::ENOENT
      pad do
        puts "Configuration cannot be found, please run 'troo init'" \
             " first."
      end
    rescue Redis::CannotConnectError
      pad do
        puts 'Cannot connect to Redis database.'
      end
    rescue ExpiredAccessToken
      pad do
        puts 'Your Trello access token has expired. Please renew.'
      end
    ensure
      $stdin, $stdout, $stderr = STDIN, STDOUT, STDERR
      @kernel.exit(exit_code)
    end

    private

    attr_accessor :exit_code

    def pad
      puts
      yield
      puts
    end
  end
end
