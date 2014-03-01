require 'pry'
require 'pry-nav'
require 'ruby-prof'

module Troo
  def self.debug(filename = 'profile.html', &block)
    path   = File.dirname(__FILE__) + '/../../tmp/'
    ignore = File.dirname(__FILE__) + '/../../config/ignore'

    RubyProf.start

    yield

    result = RubyProf.stop
    result.eliminate_methods!([/^Array/, /^Hash/])

    File.open(path + filename, 'w') do |file|
      RubyProf::CallStackPrinter.new(result).print(file)
    end
  end
end
