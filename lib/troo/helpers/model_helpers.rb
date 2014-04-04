module Troo
  module ModelHelpers
    module ClassMethods
      # @param  []
      # @return []
      def first(criteria = {})
        return all.first if criteria.nil? || criteria.empty?
        find(criteria).first
      end

      # @param  []
      # @return []
      def update(criteria = {})
        return false if criteria.nil? || criteria.empty?
        all.map { |record| record.update(criteria) }
        true
      end

      # @return []
      def default
        first(default: true)
      end

      # @return []
      def default?
        !!(default)
      end

      # @param  []
      # @return []
      def count(criteria = {})
        return all.count if criteria.empty?
        find(criteria).size
      end

      # @param  []
      # @return []
      def by_external_id(id)
        first(external_id: id)
      end

      # @param  []
      # @param  []
      # @return []
      def retrieve(id = nil, options = {})
        Troo::Retrieval::Local.retrieve(self, id, options)
      end
    end

    module InstanceMethods
      def set_default!
        Behaviours::SetDefault.for(self)
      end
    end

    def self.included(receiver)
      receiver.extend(ClassMethods)
      receiver.send(:include, InstanceMethods)
    end
  end
end
