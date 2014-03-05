module Troo
  module Decorators
    class Card < Resource
      include DecoratorHelpers

      def short
        [default, id_str, name_str].join + "\n"
      end

      def name_str
        highlight(name, options)
      end

      def description
        if klass.desc.nil? || klass.desc.empty?
          'There are no further details at this time.'
        else
          word_wrap(klass.desc)
        end
      end

      def comments
        if klass.comments.any? && klass.comments.size > 3
          message = "(There are more comments, use: " \
                    "'troo show comments #{klass.short_id}' to view " \
                    " all comments.)"
          [decorated_recent_comments, message].join("\n")
        elsif klass.comments.any?
          decorated_all_comments
        else
          'No comments have been left.'
        end
      end

      def members
        Presenters::Member.show(klass)
      end

      def last_activity_date
        return 'N/A' unless klass.last_activity_date
        Time.parse(klass.last_activity_date)
            .strftime('%a, %b %d at %H:%M')
      end

      private

      def defaults
        {
          ansicolor: true,
          colour:    Esc.magenta,
          underline: Esc.underline
        }
      end

      def decorated_recent_comments
        klass.recent_comments.map do |comment|
          comment.decorator.as_view
        end.join
      end

      def decorated_all_comments
        klass.comments.map { |comment| comment.decorator.as_view }.join
      end
    end
  end
end
