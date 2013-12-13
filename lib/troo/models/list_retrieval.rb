module Troo
  class ListRetrieval
    def initialize(id = nil)
      @id = id
    end

    def self.current
      Troo::List.first(current: true)
    end

    def self.retrieve(id = nil)
      new(id).retrieve
    end

    def retrieve
      all || by_id || by_external_id || remote
    end

    private
    attr_reader :id

    def all
      return all_lists unless id
      nil
    end

    def all_lists
      Troo::List.all
    end

    def by_id
      Troo::List.get(id)
    end

    def by_external_id
      Troo::List.first(external_list_id: id)
    end

    def remote
      ExternalList.fetch(id, { mode: :list }).first
    end
  end
end
