module Ctrlo
  class CommentRetrieval
    def initialize(id = nil)
      @id = id
    end

    def self.retrieve(id = nil)
      new(id).retrieve
    end

    def retrieve
      all || by_id || by_external_id
    end

    private
    attr_reader :id

    def all
      return all_comments unless id
      nil
    end

    def all_comments
      Ctrlo::Comment.all
    end

    def by_id
      Ctrlo::Comment.get(id)
    end

    def by_external_id
      Ctrlo::Comment.first(external_comment_id: id)
    end
  end
end
