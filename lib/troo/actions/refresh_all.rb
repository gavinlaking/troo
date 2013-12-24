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
        ExternalList.fetch(id, options)

        Troo.logger.debug "Fetching members..."
        ExternalMember.fetch(id, options)

        Troo.logger.debug "Fetching cards..."
        ExternalCard.fetch(id, options).map do |card|
          Troo.logger.debug "Fetching comments for card ##{card.short_id}..."
          ExternalComment.fetch(card.external_card_id, { mode: :card })
        end
      end
      true
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
