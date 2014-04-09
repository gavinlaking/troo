module Troo
  module ModelHelpers
    module ClassMethods
      # @param  [Hash]
      # @return [Ohm::Model]
      def first(criteria = {})
        return all.first if criteria.nil? || criteria.empty?
        find(criteria).first
      end

      # @param  [Hash]
      # @return [TrueClass]
      def update(criteria = {})
        return false if criteria.nil? || criteria.empty?
        all.map { |record| record.update(criteria) }
        true
      end

      # @return [Ohm::Model]
      def default
        first(default: true)
      end

      # @return [TrueClass, FalseClass]
      def default?
        !!(default)
      end

      # @param  [Hash]
      # @return [Integer]
      def count(criteria = {})
        return all.count if criteria.empty?
        find(criteria).size
      end

      # @param  [String]
      # @return [Ohm::Model]
      def by_external_id(id)
        first(external_id: id)
      end

      # @param  [String, NilClass]
      # @param  [Hash]
      # @return [Ohm::Model]
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
