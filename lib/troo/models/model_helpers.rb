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
    end

    def self.included(base)
      base.extend(ClassMethods)
    end

    def external_attributes
      self.attributes.delete_if { |k, _| k == :id || k == :current }
    end
  end
end
