module Troo
  module Commands
    module Status
      class Card < Resource
        private

        def success
          '  Cards:  ' + plural('card') + " found.\n" +
          "          #{resource_title}"
        end

        def error
          if count > 0
            '  Cards:  ' + no_default_error + " (#{count})"
          else
            "  Cards:  No cards found.\n"
          end
        end

        def count
          @count ||= Troo::Card.count
        end

        def resource
          @resource ||= Retrieval::Card.default
        end

        def no_default_error
          Esc.red + 'No default card set.' + Esc.reset
        end
      end
    end
  end
end
