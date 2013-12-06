module Ctrlo
  class RefreshBoards
    def initialize(external_id, options = {})
      @enternal_id = external_id
      @options     = options
    end

    def self.for(external_id, options = {})
      new(external_id, options).refresh
    end

    def self.all
      Board.persist ExternalBoard.fetch
    end

    def refresh
      Board.persist ExternalBoard.fetch_by_external_id(external_id)
    end

    private
    attr_reader :external_id
  end
end
