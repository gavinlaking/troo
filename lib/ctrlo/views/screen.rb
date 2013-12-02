module Ctrlo
  class Screen
    def initialize(object)
      @object = object
    end

    def self.render(object)
      new(object).render
    end

    def render
      puts ERB.new(object.to_s).result(binding)
    end

    private
    attr_reader :object
  end
end
