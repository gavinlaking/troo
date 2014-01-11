module Troo
  class ExternalList
    def initialize(external_id, options = {})
      @external_id = external_id
      @options     = options
    end

    def self.fetch(external_id, options = {})
      new(external_id, options).fetch_by_external_id.map do |resource|
        Troo::ListPersistence.for(resource) unless closed?(resource)
      end
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
    rescue Trello::InvalidAccessToken
      raise Troo::InvalidAccessToken
    rescue Trello::Error
      []
    end

    def list_mode
      [Trello::List.find(external_id)]
    rescue Trello::InvalidAccessToken
      raise Troo::InvalidAccessToken
    rescue Trello::Error
      []
    end

    def self.closed?(resource)
      resource.nil? || resource.closed?
    end
  end
end
