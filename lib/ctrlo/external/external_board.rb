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

    def fetch
      Trello::Board.all
    end

    def fetch_by_external_id
      [Trello::Board.find(external_id)]
    end

    private
    attr_reader :external_id
  end
end
