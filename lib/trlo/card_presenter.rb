module Trlo
  class CardPresenter
    def initialize(list_id)
      raise ListNotFound, "No list specified, no cards found." if list_id.nil?
      @list_id = list_id
    end

    def self.all(list_id)
      new(list_id).all
    end

    def all
      Screen.new(all_cards_header, all_cards_content).render
    end

    private
    attr_reader :list_id

    def all_cards_header
      { short_id: "ID", name: "Name" }
    end

    def all_cards_content
      Trello::List.find(list_id).cards.map do |card|
        CardDecorator.new(card).to_hash
      end
    end
  end
end
