module Troo
  module Commands
    module Status
      class Resource
        class << self
          def dispatch
            new.report_status
          end
        end

        def report_status
          return success if resource
          error
        end

        private

        def success
          "  #{type.capitalize}s:  " + plural + " found.\n" +
          "          #{resource_title}"
        end

        def error
          if count > 0
            "  #{type.capitalize}s:  " + no_default_error + " (#{count})"
          else
            "  #{type.capitalize}s:  No #{type}s found.\n"
          end
        end

        def resource_title
          resource.decorator.title
        end

        def no_default_error
          Esc.red + "No default #{type} set." + Esc.reset
        end

        def plural
          if count == 1
            "#{count} #{type}"
          else
            "#{count} #{type}s"
          end
        end
      end
    end
  end
end
