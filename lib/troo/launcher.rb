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
      @argv = argv
      @stdin = stdin
      @stdout = stdout
      @stderr = stderr
      @kernel = kernel
    end

    # @return []
    def execute!
      $stdin, $stdout, $stderr = @stdin, @stdout, @stderr
      pad { Troo::CLI::Main.start(@argv) }
      @kernel.exit(0)
    rescue Errno::ENOENT
      pad { puts "Configuration cannot be found, please run 'troo init'" \
                 " first." }
      @kernel.exit(1)
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
