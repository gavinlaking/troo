module Ctrlo
  class ExternalComment
    def initialize(external_id, options = {})
      raise StandardError, "external_id expected, none given" if external_id.nil?
      @external_id = external_id
      @options     = options
    end

    def self.request(external_id, options = {})
      new(external_id, options).request
    end

    def request
      #return singular? ? singular : collection
      collection
    end

    private
    attr_reader :external_id, :options

    def collection
      Trello::Board.find(external_id).
          actions.collect   { |a| a if a.type == "commentCard" }.
                  delete_if { |a| a.nil? }
    rescue Trello::Error => e
      puts e.message
      exit 1
    end

    # def singular
    #   Trello::Card.find(external_id).
    #       actions.collect   { |a| a if a.type == "commentCard" }.
    #               delete_if { |a| a.nil? }
    # rescue Trello::Error => e
    #   puts e.message
    #   exit 1
    # end

    # def singular?
    #   options.fetch(:by_comment_id, false)
    # end

  end
end
