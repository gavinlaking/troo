module Troo
  class Align
    include Virtus.value_object

    values do
      attribute :pos,   Symbol,  default: :none
      attribute :pad,   Integer, default: 0
      attribute :char,  String,  default: ' '
      attribute :width, Integer, default: 80
      attribute :prune, Boolean, default: false
    end
  end
end
