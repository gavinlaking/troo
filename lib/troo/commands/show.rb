module Troo
  module CLI
    module Commands
      class Show
        include CommandHelpers

        class << self
          def dispatch(type, id = nil)
            new(type, id).show_resource
          end
        end

        def initialize(type, id = nil)
          @type, @id = type, id
        end

        def show_resource
          if resource
            success
          elsif id.nil?
            error_no_default
          else
            error_not_found
          end
        end

        private
        attr_reader :type, :id

        def success
          return resource.comment_presenter.show if type == :comments
          resource.presenter.show
        end

        def resource
          case type
          when :board    then BoardRetrieval.retrieve(id)
          when :list     then ListRetrieval.retrieve(id)
          when :card     then CardRetrieval.retrieve(id)
          when :comments then CardRetrieval.retrieve(id)
          end
        end
      end
    end
  end
end
