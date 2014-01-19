module Troo
  module CLI
    module Helpers
      def resource
        @resource ||= case type
        when :board then BoardRetrieval.retrieve(id)
        when :list  then ListRetrieval.retrieve(id)
        when :card  then CardRetrieval.retrieve(id)
        end
      end

      def not_found
        say "#{type.to_s.capitalize} cannot be found."
      end
    end

    class ThorFixes < Thor
      def self.banner(command, namespace = nil, subcommand = false)
        "#{basename} #{@package_name} #{command.usage}"
      end
    end
  end
end
