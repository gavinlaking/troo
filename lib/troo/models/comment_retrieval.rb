module Troo
  class CommentRetrieval
    def initialize(id)
      @id = id
    end

    def self.all
      Troo::Comment.all
    end

    def self.retrieve(id)
      new(id).retrieve
    end

    def retrieve
      by_id || by_external_id
    end

    private
    attr_reader :id

    def by_id
      Troo::Comment[id]
    end

    def by_external_id
      Troo::Comment.first(external_comment_id: id)
    end
  end
end
