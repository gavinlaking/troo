module Troo
  module CLI
    class List < Thor

      desc "show <list_id>", "Show all cards for list <list_id>"
      def show(list_id)
        @list_id = list_id
        if list
          ListPresenter.render_show(list)
        else
          say "List not found."
        end
      end

      private
      attr_reader :list_id

      def list
        @list ||= Troo::ListRetrieval.retrieve(list_id)
      end
    end
  end
end
