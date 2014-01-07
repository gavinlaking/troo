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
      unset_default
      set_new_default
      entity
    end

    private
    attr_reader :entity

    def set_new_default
      entity.update(default: true)
    end

    def unset_default
      entity.class.update(default: false)
    end

    def already_default?
      entity.default?
    end
  end
end
