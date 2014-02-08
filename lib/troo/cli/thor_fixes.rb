module Troo
  module CLI
    class ThorFixes < Thor
      # def self.exit_on_failure?
      #  true # exit code is non-zero on error
      # end

      def self.banner(command, namespace = nil, subcommand = false)
        "#{basename} #{@package_name} #{command.usage}"
      end
    end
  end
end
