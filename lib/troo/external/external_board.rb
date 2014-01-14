module Troo
  class ExternalBoard
    class << self
      def fetch(external_id, options = {})
        new(external_id, options).fetch_by_external_id.map do |resource|
          Troo::BoardPersistence.for(resource) unless closed?(resource)
        end
      end

      def fetch_all
        new.fetch_all.map do |resource|
          Troo::BoardPersistence.for(resource) unless closed?(resource)
        end
      end

      private

      def closed?(resource)
        resource.nil? || resource.closed?
      end
    end

    def initialize(external_id = nil, options = {})
      @external_id = external_id
      @options     = options
    end

    def fetch_by_external_id
      [Trello::Board.find(external_id)]
    rescue Trello::InvalidAccessToken
      raise Troo::InvalidAccessToken
    rescue Trello::Error
      []
    end

    def fetch_all
      Trello::Board.all
    rescue Trello::InvalidAccessToken
      raise Troo::InvalidAccessToken
    rescue Trello::Error
      []
    end

    private
    attr_reader :external_id
  end
end
