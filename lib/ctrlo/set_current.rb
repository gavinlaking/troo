module Trlo
  class SetCurrent
    def initialize(entity)
      @entity = entity
    end

    def self.for(entity)
      new(entity).set_current!
    end

    def set_current!
      entity.class.update(current: false)
      entity.update(current: true)
    end

    private
    attr_reader :entity
  end
end
