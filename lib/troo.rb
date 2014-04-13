$LOAD_PATH << File.expand_path(File.dirname(__FILE__) + '/../lib')

require_relative 'troo/troo'
require_relative 'troo/version'

module Troo
  ConfigurationNotFound = Class.new(StandardError)
  ExpiredAccessToken    = Class.new(StandardError)
  EndpointNotFound      = Class.new(StandardError)

  # @param  [String]
  # @param  [String]
  # @return [Troo::Configuration]
  def self.configuration(file = Dir.home + '/.trooconf', env = 'default')
    unless File.exist?(file)
      warn "\nConfiguration cannot be found, please run 'troo " \
           "init' or './bin/troo init' first.\n"
      file = root_path + '/config/trooconf.yml'
    end

    @configuration ||= Troo::Configuration.load(file, env)
  end

  # @return [TrueClass]
  def self.logger
    @logger ||= Logger
      .new(root_path + '/logs/troo.log').tap do |log|
      log.formatter = proc do |mode, time, prog, msg|
        "\n" + Esc.green + "#{time.iso8601}:" + Esc.reset + " #{msg}\n"
      end
    end
  end

  def self.root_path
    File.expand_path('../..', __FILE__)
  end

  # RestClient.log = log_dir + '/restclient.log'

  Database.connect(configuration)
end
