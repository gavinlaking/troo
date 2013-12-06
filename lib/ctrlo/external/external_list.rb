module Ctrlo
  class ExternalList
    include Helpers

    def initialize(external_id, options = {})
      @external_id = external_id
      @options     = options
    end

    def self.fetch(external_id, options = {})
      Ctrlo::List.persist new(external_id, options).fetch_by_external_id
    end

    def fetch_by_external_id
      case options.fetch(:mode)
      when :board then board_mode
      when :list  then list_mode
      end
    end

    private
    attr_reader :external_id

    def options
      defaults.merge!(@options)
    end

    def defaults
      { mode: :board }
    end

    def board_mode
      Trello::Board.find(external_id).lists
    rescue Trello::Error
    end

    def list_mode
      [Trello::List.find(external_id)]
    rescue Trello::Error
    end

  end
end
