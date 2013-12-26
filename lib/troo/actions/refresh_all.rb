module Troo
  class RefreshAll
    def initialize(options = {})
      @options = options
    end

    def self.perform(options = {})
      new(options).perform
    end

    def perform
      external_board_ids.map do |id|
        Troo.logger.debug "Fetching lists..."
        lists(id)

        Troo.logger.debug "Fetching members..."
        ExternalMember.fetch(id, options)

        Troo.logger.debug "Fetching cards..."
        cards(id)
      end
      true
    end

    def self.lists(options = {}, external_board_id = nil)
      new(options).lists(external_board_id)
    end

    def lists(external_board_id = nil)
      if external_board_id
        ExternalList.fetch(external_board_id, options)
      elsif Troo::BoardRetrieval.current
        ExternalList.fetch(Troo::BoardRetrieval.current.external_board_id, options)
      end
    end

    def self.cards(options = {}, external_board_id = nil)
      new(options).cards(external_board_id)
    end

    def cards(external_board_id = nil)
      if external_board_id
        ExternalCard.fetch(external_board_id, options)
      elsif Troo::BoardRetrieval.current
        ExternalCard.fetch(Troo::BoardRetrieval.current.external_board_id, options)
      end
    end

    private

    def options
      defaults.merge!(@options)
    end

    def defaults
      { mode: :board }
    end

    def external_board_ids
      active_boards.map(&:external_board_id)
    end

    def active_boards
      all_boards.delete_if { |b| b.nil? || b.closed == true }
    end

    def all_boards
      @boards ||= ExternalBoard.fetch_all
    end
  end
end
