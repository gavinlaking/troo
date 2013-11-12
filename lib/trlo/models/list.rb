module Trlo
  class List
    def initialize(list)
      @list = list
    end

    def self.decorate(list)
      new(list).decorate
    end

    def decorate
      { id: id, name: name, header: header }
    end

    def id
      list.id
    end

    def name
      list.name
    end

    private
    attr_reader :list

    def header
      { id: "ID", name: "Name" }
    end
  end

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

  class FindLists
    def initialize(board_id)
      @board_id = board_id
    end

    def self.for(board_id)
      new(board_id).all_lists
    end

    def all_lists
      FindBoard.with(board_id).lists.map do |list|
        List.decorate(list)
      end
    end

    private
    attr_reader :board_id
  end
end

