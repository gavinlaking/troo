module Ctrlo
  class ExternalBoard
    include Helpers

    def initialize(external_id = nil, options = {})
      @external_id = external_id
      @options     = options
    end

    def self.fetch(external_id, options = {})
      new(external_id, options).fetch_by_external_id.map do |resource|
        Ctrlo::BoardPersistence.for(resource)
      end
    end

    def fetch_by_external_id
      [Trello::Board.find(external_id)]
    #rescue Trello::Error
    end

    def self.fetch_all
      new.fetch_all.map do |resource|
        Ctrlo::BoardPersistence.for(resource)
      end
    end

    def fetch_all
      Trello::Board.all
    # rescue Trello::Error
    end

    private
    attr_reader :external_id
  end
end
