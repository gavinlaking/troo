module Troo
  class ExternalComment
    def initialize(external_id, options = {})
      @external_id = external_id
      @options     = options
    end

    def self.fetch(external_id, options = {})
      new(external_id, options).fetch_by_external_id.map do |resource|
        Troo::CommentPersistence.for(resource)
      end
    end

    def fetch_by_external_id
      case options.fetch(:mode)
      when :board then board_mode
      when :list  then list_mode
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
      Troo.logger.debug "Fetching remote comments for board..."
      Trello::Board.find(external_id).actions({ filter: "commentCard" }).
        delete_if { |a| a.nil? || a.type != "commentCard" }
    rescue Trello::Error
      []
    end

    def list_mode
      Troo.logger.debug "Fetching remote comments for list..."
      Trello::List.find(external_id).actions({ filter: "commentCard" }).
        delete_if { |a| a.nil? || a.type != "commentCard" }
    rescue Trello::Error
      []
    end

    def card_mode
      Troo.logger.debug "Fetching remote comments for card..."
      Trello::Card.find(external_id).actions({ filter: "commentCard" }).
        delete_if { |a| a.nil? || a.type != "commentCard" }
    rescue Trello::Error
      []
    end
  end
end
