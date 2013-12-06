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
      Comment.persist ExternalComment.fetch_by_external_id(external_id, { mode: :board })
    end

    private
    attr_reader :external_id
  end
end
