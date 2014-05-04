module Troo
  class Format
    include Virtus.value_object

    values do
      attribute :ansicolor, Boolean,     default: true
      attribute :colour,    String
      attribute :underline, Boolean,     default: false
      attribute :reset,     String,      default: Esc.reset
      attribute :align,     Troo::Align, default: Troo::Align.new
    end

    # @return [String]
    def underline
      @underline ? Esc.underline : nil
    end
  end
end
