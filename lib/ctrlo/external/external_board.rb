module Ctrlo
  class ExternalBoard
    include Helpers

    def initialize(external_id = nil)
      @external_id = external_id
    end

    def self.fetch
      new.fetch
    end

    def self.fetch_by_external_id(external_id)
      new(external_id).fetch_by_external_id
    end

    def self.refresh(external_id, options = {})
      Ctrlo::Board.persist new(external_id, options).fetch_by_external_id
    end

    def self.refresh_all
      Ctrlo::Board.persist new.fetch
    end

    def fetch
      Trello::Board.all
    rescue Trello::Error
    end

    def fetch_by_external_id
      [Trello::Board.find(external_id)]
    rescue Trello::Error
    end

    private
    attr_reader :external_id
  end
end
