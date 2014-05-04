require 'pry'
require 'pry-nav'
require 'ruby-prof'

module Troo
  # @param  filename [String]
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

  # @return []
  def self.trace
    trace = TracePoint.new(:call) do |tp|
      if tp.defined_class.to_s.match(/Troo/)
        Troo.logger.debug [tp.defined_class.to_s, tp.method_id.to_s].join(' ')
      end
    end
    trace.enable
  end
end
