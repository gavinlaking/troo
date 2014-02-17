module Troo
  module CommandHelpers
    module ClassMethods
    end

    def self.included(base)
      base.extend(ClassMethods)
    end

    def error_no_default
      @type = :card if type == :comments
      "Specify an <id> or use 'troo default #{type_str} <id>' " \
      "to set a default #{type_str} first."
    end

    def error_not_found
      @type = :card if type == :comments
      "#{type_capitalize} cannot be found. " + error_no_default
    end

    def type_str
      type.to_s
    end

    def type_capitalize
      type_str.capitalize
    end

    def no_default?
      id.nil?
    end
  end
end
