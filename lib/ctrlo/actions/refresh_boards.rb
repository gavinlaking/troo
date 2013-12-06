module Ctrlo
  class RefreshBoards
    def initialize(external_id, options = {})
      @external_id = external_id
      @options     = options
    end

    def self.for(external_id, options = {})
      new(external_id, options).refresh
    end

    def self.all
      Board.persist collection
    end

    def refresh
      Board.persist entity
    end

    private
    attr_reader :external_id

    def collection
      ExternalBoard.fetch
    end

    def entity
      ExternalBoard.fetch_by_external_id(external_id)
    end
  end
end
