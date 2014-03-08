module Troo
  module Decorators
    class Resource
      include DecoratorHelpers

      def initialize(klass, options = {})
        @klass, @options = klass, options
      end

      def title
        [
          brackets(klass.id),
          Troo::Formatter.highlight(name, options),
          default
        ].compact.join(' ') + "\n"
      end

      def description
        return 'N/A' if klass.description.nil? ||
                        klass.description.empty?
        Troo::Formatter.wordwrap(klass.description)
      end

      def default
        klass.default? ? '*' : nil
      end

      def name
        (klass.name && klass.name.chomp) || 'N/A'
      end

      def board
        klass.board.decorator(options)
      end

      def list
        klass.list.decorator(options)
      end

      def lists(alt_options = {})
        klass.lists.map { |list| list.decorator(alt_options) }
      end

      def cards(alt_options = {})
        klass.cards.map { |card| card.decorator(alt_options) }
      end

      def comments
        if klass.comments.any? && klass.comments.size > 3
          msg = '(There are more comments, use: ' \
                "'troo show comments #{klass.short_id}' to view " \
                ' all comments.)'
          [decorated_recent_comments, msg].join("\n")
        elsif klass.comments.any?
          decorated_all_comments
        else
          'No comments have been left.'
        end
      end

      def members
        Presenters::Member.new(klass).show
      end

      def last_activity_date
        return 'N/A' unless klass.last_activity_date
        Time.parse(klass.last_activity_date)
            .strftime('%a, %b %d at %H:%M')
      end

      def as_view
        Template.parse(self, "/../views/" + type + ".erb")
      end

      def username
        ['@', klass.member.username].join
      end

      def text
        Troo::Formatter.wordwrap(klass.text)
      end

      def date
        Time.parse(klass.date).strftime('%a, %b %d at %H:%M')
      end

      private

      attr_reader :klass, :options

      def type
        klass.type.to_s
      end

      def decorated_recent_comments
        klass.recent_comments.map do |comment|
          comment.decorator.as_view
        end.join
      end

      def decorated_all_comments
        klass.comments.map do |comment|
          comment.decorator.as_view
        end.join
      end

      def options
        defaults.merge!(@options)
      end

      def defaults
        {
          ansicolor: true,
          colour:    colour.fetch(klass.type, nil),
          underline: false,
        }
      end

      def colour
        {
          board:    Esc.blue,
          card:     Esc.magenta,
          list:     Esc.green,
          comments: Esc.cyan,
          member:   Esc.white
        }
      end
    end
  end
end
