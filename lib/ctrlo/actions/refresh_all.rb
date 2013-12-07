module Ctrlo
  class RefreshAll
    def initialize(options = {})
      @options = options
    end

    def self.perform(options = {})
      new(options).perform
    end

    def perform
      external_board_ids.map do |id|
        ExternalList.fetch(id, options)
        ExternalCard.fetch(id, options)
        ExternalComment.fetch(id, options)
        ExternalMember.fetch(id, options)
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
      all_boards.delete_if { |b| b.closed == true }
    end

    def all_boards
      @boards ||= ExternalBoard.fetch_all
    end
  end
end
