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

      def count
        all.count
      end
    end

    def self.included(base)
      base.extend(ClassMethods)
    end
  end
end
