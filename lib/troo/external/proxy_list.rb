module Troo
  class ProxyList
    # def initialize(list)
    #   @list = list
    # end

    # def self.for(list)
    #   new(list).duck
    # end

    # def duck
    #   Trello::List.new.update_fields({'id' => list.external_list_id})
    # end

    def self.create(options)
      Trello::List.create(options)
    end

    private
    # attr_reader :list
  end
end
