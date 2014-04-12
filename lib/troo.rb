$LOAD_PATH << File.expand_path(File.dirname(__FILE__) + '/../lib')

require_relative 'troo/troo'
require_relative 'troo/version'

module Troo
  ExpiredAccessToken    = Class.new(StandardError)
  EndpointNotFound      = Class.new(StandardError)

  # @param  []
  # @param  [String]
  # @return []
  def self.configuration(file = Dir.home + '/.trooconf', env = 'default')
    unless File.exist?(file)
      warn "\nConfiguration cannot be found, please run 'troo " \
           "init' or './bin/troo init' first.\n"
      file = configuration_path + '/trooconf.yml'
    end

    @configuration ||= Troo::Configuration.load(file, env)
  end

  # @param  [String]
  # @return []
  def self.endpoints(version = 'version_1')
    @endpoints ||= Troo::API::Endpoints
      .load(configuration_path + '/trello_api.yml', version)
  end

  # @return []
  def self.logger
    @logger ||= Logger
      .new(log_path + '/troo.log').tap do |log|
      log.formatter = proc do |mode, time, prog, msg|
        "#{time.iso8601}: #{msg}\n"
      end
    end
  end

  # RestClient.log = log_dir + '/restclient.log'

  Database.connect(configuration)

  private

  def self.configuration_path
    File.dirname(__FILE__) + '/../config'
  end

  def self.log_path
    File.dirname(__FILE__) + '/../logs'
  end
end
