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
      @exit_code = 0
    rescue ConfigurationNotFound
      pad do
        puts "Configuration cannot be found, please run " \
             "`troo wizard` for help, or 'troo init' to manually " \
             "configure."
      end
    rescue ConfigurationAborted
      pad { puts 'Configuration wizard aborted.' }
    rescue Redis::CannotConnectError
      pad { puts 'Cannot connect to Redis database.' }
    rescue ExpiredAccessToken
      pad do
        puts "Your Trello access token has expired, please run " \
             "`troo wizard` for help, or manually renew."
      end
    ensure
      $stdin, $stdout, $stderr = STDIN, STDOUT, STDERR
      @kernel.exit(@exit_code)
    end

    private

    def pad
      puts
      yield
      puts
    end
  end
end
