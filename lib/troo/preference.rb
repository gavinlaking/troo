module Troo
  class Preference
    include Virtus.value_object

    values do
      attribute :label, String
      attribute :value, String
    end

    class << self
      # @param  [Hash]
      # @return []
      def view(parameters)
        new(parameters).view
      end
    end

    # @return [String]
    def view
      [formatted_label, value].join(' ')
    end

    private

    def formatted_label
      (label + ':').rjust(25, ' ')
    end
  end
end
