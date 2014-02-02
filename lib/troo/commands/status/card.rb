module Troo
  module Commands
    module Status
      class Card
        include CommandHelpers

        class << self
          def dispatch
            new.get_status
          end
        end

        def get_status
          return success if resource
          return error
        end

        private

        def success
          "  Cards:  " + plural("card") + " found.\n" +
          "          #{resource_title}"
        end

        def error
          if count > 0
            "  Cards:  " + Esc.red + "No default card set." + Esc.reset
          else
            "  Cards:  No cards found.\n"
          end
        end

        def resource_title
          resource.decorator.title
        end

        def count
          @count ||= Troo::Card.count
        end

        def resource
          @resource ||= Retrieval::Card.default
        end

        def plural(singular)
          count == 1 ? "#{count} #{singular}" : "#{count} #{singular}s"
        end
      end
    end
  end
end
