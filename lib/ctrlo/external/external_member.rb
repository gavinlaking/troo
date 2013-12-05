module Ctrlo
  class ExternalMember
    include Helpers

    def initialize(external_id, options = {})
      @external_id = external_id
      @options     = options
    end

    def self.fetch_by_external_id(external_id, options = {})
      new(external_id, options).fetch_by_external_id
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
    ensure
      notify "Remote members for board fetched."
    end

    def member_mode
      [Trello::Member.find(external_id)]
    ensure
      notify "Remote member fetched."
    end

  end
end
