module Troo
  class MemberPresenter
    include DecoratorHelpers

    def initialize(card, options = {})
      @card    = card
      @options = options
    end

    def self.render_show(card, options = {})
      new(card, options).render_show
    end

    def render_show
      decorated_members
    end

    private
    attr_reader :card

    def decorated_members
      if one_member?
        members.first
      elsif two_members?
        members.join(" and ")
      elsif many_members?
        word_wrap([all_but_last_member, last_member].join(" and "))
      else
        "No members have been assigned."
      end
    end

    def members
      @members ||= card.members.map { |member| MemberDecorator.new(member).username }
    end

    def one_member?
      members.size == 1
    end

    def two_members?
      members.size == 2
    end

    def many_members?
      members.size > 2
    end

    def all_but_last_member
      members[0...-1].join(", ")
    end

    def last_member
      members[-1]
    end
  end
end
