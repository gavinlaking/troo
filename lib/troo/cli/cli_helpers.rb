module Troo
  module CLI
    module Helpers
      def set_default
        return success if resource && resource.set_default!
        not_found
      end

      def success
        say "'#{resource.name}' set as default #{type.to_s.downcase}."
        true
      end

      def not_found
        say "#{type.to_s.capitalize} cannot be found. Specify a different <id> or use 'troo default #{type.to_s} <id>' to set a default #{type.to_s} first."
        false
      end

      def resource
        @resource ||= case type
        when :board then BoardRetrieval.retrieve(id)
        when :list  then ListRetrieval.retrieve(id)
        when :card  then CardRetrieval.retrieve(id)
        end
      end
    end

    class ThorFixes < Thor
      def self.banner(command, namespace = nil, subcommand = false)
        "#{basename} #{@package_name} #{command.usage}"
      end
    end
  end
end
