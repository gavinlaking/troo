module Ctrlo
  class ListPresenter
    def initialize(lists, options = {})
      @lists  = lists
      @options = options
    end

    def self.render(lists, options = {})
      new(lists, options).render
    end

    def render
      lists.each do |list|
        ListDecorator.new(list).short if show_lists?

        list.cards.each do |card|
          if show_cards?
            indent if show_lists?
            CardDecorator.new(card).short
          end
        end
      end
      nil
    end

    private

    def show_lists?; options.fetch(:show_lists); end
    def show_cards?; options.fetch(:show_cards); end

    def lists
      @lists.is_a?(Array) ? @lists : [@lists]
    end

    def options
      defaults.merge!(@options)
    end

    def defaults
      {
        show_lists: false,
        show_cards: false
      }
    end

    def indent
      print " " * 4
    end
  end
end
