require_relative '../../../test_helper'

module Troo
  module Decorators
    class DecoratorHelpersDummy < Resource
      include Troo::DecoratorHelpers
    end
  end
end

module Troo
  describe DecoratorHelpers do
    let(:described_class)    { Troo::Decorators::DecoratorHelpersDummy }
    let(:described_instance) { described_class.new(klass, options) }
    let(:klass)              { stub }
    let(:options)            { {} }
  end
end
