require 'pry'
require 'pry-nav'
require 'ruby-prof'

module Troo
  # @param  []
  # @param  []
  # @return []
  def self.debug(filename = 'profile.html', &block)
    RubyProf.start

    yield

    result = RubyProf.stop
    result.eliminate_methods!([/^Array/, /^Hash/])

    File.open('./tmp/' + filename, 'w') do |file|
      RubyProf::CallStackPrinter.new(result).print(file)
    end
  end
end
