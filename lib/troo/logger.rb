module Troo
  def self.logger
    path = File.dirname(__FILE__)

    @logger ||= Logger
      .new(path + '/../logs/troo.log').tap do |log|
        log.formatter = proc do |mode, time, prog, msg|
          "%s %5s:\n%s\n" % [time.iso8601, mode, msg]
      end
    end
  end
end
