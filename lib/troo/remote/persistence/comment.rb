module Troo
  module Remote
    module Persistence
      class Comment
        class << self
          def with(external_card_id, comment)
            new(external_card_id, comment).perform
          end
        end

        def initialize(external_card_id, comment)
          @external_card_id = external_card_id
          @comment          = comment
        end

        def perform
          create_local
        end

        private

        attr_reader :external_card_id, :comment

        def create_local
          return Troo::Persistence::Local
            .with_collection(resource).first if any?
          false
        end

        def any?
          resource.any?
        end

        def resource
          @resource ||= API::Client.perform(parameters)
        end

        def parameters
          {
            verb:          :post,
            endpoint:      :create_comment,
            interpolation: interpolation,
            query:         query,
            model:         Remote::Comment
          }
        end

        def interpolation
          { external_id: external_card_id }
        end

        def query
          { text: comment }
        end
      end
    end
  end
end
