module Troo
  module ModelHelpers
    module ClassMethods
      def first(criteria = {})
        return all.first if criteria.nil? || criteria.empty?

        find(criteria).first
      end

      def update(criteria = {})
        return false if criteria.nil? || criteria.empty?

        all.map { |record| record.update(criteria) }
        true
      end

      def default
        first(default: true)
      end

      def default?
        !!(default)
      end

      def count(criteria = {})
        return all.count if criteria.empty?

        find(criteria).size
      end

      def by_external_id(id)
        first(external_id: id)
      end

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
