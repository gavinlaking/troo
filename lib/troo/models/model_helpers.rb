module Troo
  module ModelHelpers
    def external_attributes
      self.attributes.delete_if { |k, _| k == :id || k == :current }
    end
  end
end
