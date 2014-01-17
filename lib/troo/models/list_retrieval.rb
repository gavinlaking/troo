module Troo
  class ListRetrieval
    class << self
      def all
        Troo::List.all
      end

      def default
        new.retrieve
      end

      def retrieve(id = nil)
        new(id).retrieve
      end
    end

    def initialize(id = nil)
      @id = id
    end

    def retrieve
      return default unless id
      by_id || by_external_id || remote
    end

    private
    attr_reader :id

    def default
      Troo::List.default
    end

    def by_id
      Troo::List[id]
    end

    def by_external_id
      Troo::List.first(external_list_id: id)
    end

    def remote
      External::List.fetch(id, { mode: :list }).first
    end
  end
end
