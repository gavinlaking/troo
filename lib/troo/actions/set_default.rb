module Troo
  class SetDefault
    def initialize(entity)
      @entity = entity
    end

    def self.for(entity)
      new(entity).set_default!
    end

    def set_default!
      return false if already_default?
      entity.class.update(default: false)
      entity.update(default: true)
      entity
    end

    private
    attr_reader :entity

    def already_default?
      entity.default?
    end
  end
end
