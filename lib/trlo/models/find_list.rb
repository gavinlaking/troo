module Trlo
  class FindList
    def initialize(list_id)
      @list_id = list_id
    end

    def self.with(list_id)
      new(list_id).find
    end

    def find
      Trello::List.find(list_id)
    end

    private
    attr_reader :list_id
  end
end
