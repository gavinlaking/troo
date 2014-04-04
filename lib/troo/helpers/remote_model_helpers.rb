module Troo
  module RemoteModelHelpers
    module ClassMethods
      # @param  []
      # @return []
      def with_collection(resources = [])
        resources.map { |resource| new(resource) }
      end

      # @return []
      def all
        {}
      end

      # @return []
      def by_board_id
        {}
      end

      # @return []
      def by_list_id
        {}
      end

      # @return []
      def by_card_id
        {}
      end

      # @return []
      def by_member_id
        {}
      end
    end

    module InstanceMethods
      # @return []
      def preprocess
        associations.map do |association|
          associated(association).map { |record| record.preprocess }
        end

        Persistence::Local.persist(self)
      end

      # @return []
      def local
        @local ||= local_model.by_external_id(id)
      end

      private

      def associated(association)
        Array(send(association))
      end
    end

    def self.included(receiver)
      receiver.extend(ClassMethods)
      receiver.send(:include, InstanceMethods)
    end
  end
end
