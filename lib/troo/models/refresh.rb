module Troo
  class Refresh < Ohm::Model
    include Ohm::DataTypes
    include ModelHelpers

    attribute :last_performed_at, Type::Time

    index :last_performed_at

    class << self
      # @return [Troo::Refresh]
      def completed!
        all.map { |record| record.delete }
        create(last_performed_at: Time.now.to_s)
      end

      # @return [String, NilClass]
      def last_performed_at
        first ? first.last_performed_at : nil
      end
      alias_method :last_performed_at?, :last_performed_at
    end
  end
end
