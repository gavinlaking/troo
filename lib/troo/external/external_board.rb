module Troo
  class ExternalBoard
    def initialize(external_id = nil, options = {})
      @external_id = external_id
      @options     = options
    end

    def self.fetch(external_id, options = {})
      new(external_id, options).fetch_by_external_id.map do |resource|
        Troo::BoardPersistence.for(resource) unless closed?(resource)
      end
    end

    def fetch_by_external_id
      Troo.logger.debug "Fetching board..."
      [Trello::Board.find(external_id)]
    rescue Trello::Error
      []
    end

    def self.fetch_all
      new.fetch_all.map do |resource|
        Troo::BoardPersistence.for(resource) unless closed?(resource)
      end
    end

    def fetch_all
      Troo.logger.debug "Fetching boards..."
      Trello::Board.all
    rescue Trello::Error
      []
    end

    private
    attr_reader :external_id

    def self.closed?(resource)
      resource.nil? || resource.closed?
    end
  end
end
