module Troo
  class ListRetrieval
    def initialize(id = nil)
      @id = id
    end

    def self.all
      Troo::List.all
    end

    def self.current
      new.retrieve
    end

    def self.retrieve(id = nil)
      new(id).retrieve
    end

    def retrieve
      return current unless id
      by_id || by_external_id || remote
    end

    private
    attr_reader :id

    def current
      Troo::List.current
    end

    def by_id
      Troo::List[id]
    end

    def by_external_id
      Troo::List.first(external_list_id: id)
    end

    def remote
      ExternalList.fetch(id, { mode: :list }).first
    end
  end
end
