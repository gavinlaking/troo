module Troo
  class CommentRetrieval
    class << self
      def all
        Troo::Comment.all
      end

      def retrieve(id)
        new(id).retrieve
      end
    end

    def initialize(id)
      @id = id
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
