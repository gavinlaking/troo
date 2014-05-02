module Troo
  module CLI
    class ThorFixes < Thor
      # @param  command    []
      # @param  namespace  [, NilClass]
      # @param  subcommand [, FalseClass]
      # @return [String]
      def self.banner(command, namespace = nil, subcommand = false)
        [basename, @package_name, command.usage].compact.join(' ')
      end
    end
  end
end
