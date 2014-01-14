module Troo
  class ExternalMember
    class << self
      def fetch(external_id, options = {})
        new(external_id, options).fetch_by_external_id.map do |resource|
          Troo::MemberPersistence.for(resource)
        end
      end
    end

    def initialize(external_id, options = {})
      @external_id = external_id
      @options     = options
    end

    def fetch_by_external_id
      case options.fetch(:mode)
      when :board  then board_mode
      when :member then member_mode
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
      Trello::Board.find(external_id).members
    rescue Trello::InvalidAccessToken
      raise Troo::InvalidAccessToken
    rescue Trello::Error
      []
    end

    def member_mode
      [Trello::Member.find(external_id)]
    rescue Trello::InvalidAccessToken
      raise Troo::InvalidAccessToken
    rescue Trello::Error
      []
    end
  end
end
