module Troo
  module Decorators
    class Resource
      include DecoratorHelpers

      # @param  []
      # @param  []
      # @return []
      def initialize(klass, options = {})
        @klass, @options = klass, options
      end

      # @return []
      def title
        [
          resource_id,
          resource_title,
          default
        ].compact.join(' ') + "\n"
      end

      # @return []
      def resource_title
        if klass.type == :card
          Troo::Wordwrap.this(name, prune: true)
        else
          Troo::Formatter.highlight(
            Troo::Wordwrap.this(name, prune: true), options)
        end
      end

      # @return []
      def resource_id
        if klass.type == :card
          brackets(Troo::Formatter.highlight(
            Troo::Wordwrap.this(id), options))
        else
          brackets(id)
        end
      end

      # @return []
      def id
        (klass.type == :card) ? klass.short_id : klass.id
      end

      # @return []
      def description
        return 'N/A' if klass.description.nil? ||
                        klass.description.empty?
        Troo::Formatter.wordwrap(klass.description)
      end

      # @return []
      def default
        klass.default? ? '*' : nil
      end

      # @return []
      def name
        (klass.name && klass.name.chomp) || 'N/A'
      end

      # @return []
      def board
        klass.board.decorator
      end

      # @return []
      def list
        klass.list.decorator
      end

      # @return []
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

      # @return []
      def members
        Presenters::Member.new(klass).show
      end

      # @return []
      def last_activity_date
        return 'N/A' unless klass.last_activity_date
        Time.parse(klass.last_activity_date)
            .strftime('%a, %b %d at %H:%M')
      end

      # @return []
      def as_view
        Template.parse(self, '/../views/' + type + '.erb')
      end

      # @return []
      def username
        ['@', klass.member.username].join
      end

      # @return []
      def text
        Troo::Formatter.wordwrap(klass.text)
      end

      # @return []
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
          underline: true
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
