module Troo
  module ModelHelpers
    def internal_attributes
      self.attributes.keep_if   { |k, _| k == :id || k == :current }
    end

    def external_attributes
      self.attributes.delete_if { |k, _| k == :id || k == :current }
    end
  end
end
