module Troo
  module Behaviours
    class NullEntity
      # @return [FalseClass]
      def default?
        false
      end
    end

    class SetDefault
      class << self
        # @param  []
        # @return []
        def for(entity)
          new(entity).set_default!
        end
      end

      # @param  []
      # @return []
      def initialize(entity)
        @entity = entity
      end

      # @return []
      def set_default!
        return true if already_default?
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

      def entity
        return NullEntity.new if @entity.nil?
        @entity
      end
    end
  end
end
