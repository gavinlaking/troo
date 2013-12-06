module Ctrlo
  class ExternalComment
    include Helpers

    def initialize(external_id, options = {})
      @external_id = external_id
      @options     = options
    end

    def self.fetch_by_external_id(external_id, options = {})
      new(external_id, options).fetch_by_external_id
    end

    def self.refresh(external_id, options = {})
      Ctrlo::Comment.persist new(external_id, options).fetch_by_external_id
    end


    def fetch_by_external_id
      case options.fetch(:mode)
      when :board then board_mode
      when :card  then card_mode
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
      Trello::Board.find(external_id).
          actions.collect   { |a| a if a.type == "commentCard" }.
                  delete_if { |a| a.nil? }
    rescue Trello::Error
    end

    def card_mode
      Trello::Card.find(external_id).
          actions.collect   { |a| a if a.type == "commentCard" }.
                  delete_if { |a| a.nil? }
    rescue Trello::Error
    end

  end
end
