module Troo
  class Options
    include Virtus.value_object

    values do
      attribute :mode
    end
  end
end
