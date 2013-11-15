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
end

