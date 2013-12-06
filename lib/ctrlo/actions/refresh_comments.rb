module Ctrlo
  class RefreshComments
    def initialize(external_id, options = {})
      @external_id = external_id
      @options  = options
    end

    def self.for(external_id, options = {})
      new(external_id, options).refresh
    end

    def refresh
      Comment.persist collection
    end

    private
    attr_reader :external_id

    def collection
      ExternalComment.fetch_by_external_id(external_id, options)
    end

    def options
      defaults.merge!(@options)
    end

    def defaults
      { mode: :board }
    end
  end
end
