module Troo
  class ExternalCard
    class << self
      def fetch(external_id, options = {})
        new(external_id, options).fetch_by_external_id.map do |resource|
          unless closed?(resource)
            ExternalComment.fetch(resource.id, { mode: :card }) if options.fetch(:comments, true)
            Troo::CardPersistence.for(resource)
          end
        end
      end

      private

      def closed?(resource)
        resource.nil? || resource.closed?
      end
    end

    def initialize(external_id, options = {})
      @external_id = external_id
      @options     = options
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
      { comments: true, mode: :board }
    end

    def board_mode
      Trello::Board.find(external_id).cards
    rescue Trello::InvalidAccessToken
      raise Troo::InvalidAccessToken
    rescue Trello::Error
      []
    end

    def list_mode
      Trello::List.find(external_id).cards
    rescue Trello::InvalidAccessToken
      raise Troo::InvalidAccessToken
    rescue Trello::Error
      []
    end

    def card_mode
      [Trello::Card.find(external_id)]
    rescue Trello::InvalidAccessToken
      raise Troo::InvalidAccessToken
    rescue Trello::Error
      []
    end
  end
end
