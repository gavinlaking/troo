module Troo
  class Refresh < Ohm::Model
    include Ohm::DataTypes
    include ModelHelpers

    attribute :last_performed_at, Type::Time

    index :last_performed_at

    alias_method :last_performed_at?, :last_performed_at

    class << self
      def completed!
        all.map { |record| record.delete }
        create({ last_performed_at: Time.now.to_s })
      end

      def last_performed_at?
        first ? first.last_performed_at? : nil
      end
    end
  end
end
