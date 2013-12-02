module Ctrlo
  class ExternalMember
    def initialize(external_id, options = {})
      raise StandardError, "external_id expected, none given" if external_id.nil?
      @external_id = external_id
      @options     = options
    end

    def self.request(external_id, options = {})
      new(external_id, options).request
    end

    def request
      return singular? ? singular : collection
    end

    private
    attr_reader :external_id, :options

    def collection
      Trello::Board.find(external_id).members
    rescue Trello::Error => e
      puts e.message
      exit 1
    end

    def singular
      [Trello::Member.find(external_id)]
    rescue Trello::Error => e
      puts e.message
      exit 1
    end

    def singular?
      options.fetch(:by_member_id, false)
    end

  end
end
