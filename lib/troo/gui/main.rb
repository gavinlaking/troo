module Troo
  module GUI
    class Main
      include Vedeu

      event(:_initialize_) { Vedeu.trigger(:_refresh_) }

      interface 'main' do
        cursor  true
        colour  foreground: '#ffffff', background: '#111111'
        height  24
        width   12.columns
        x       1
        y       1
      end

      interface 'status' do
        cursor false
        colour foreground: '#ffffff', background: '#222222'
        height 1
        width  12.columns
        x      1
        y      use('main').bottom
      end

      interface 'command' do
        cursor true
        colour foreground: '#ffffff', background: '#333333'
        height 1
        width  12.columns
        x      1
        y      use('status').bottom
      end

      keys do
        key(:up)    { Vedeu.trigger(:_cursor_up_)    }
        key(:right) { Vedeu.trigger(:_cursor_right_) }
        key(:down)  { Vedeu.trigger(:_cursor_down_)  }
        key(:left)  { Vedeu.trigger(:_cursor_left_)  }
      end

      def self.start(argv = [])
        Vedeu::Launcher.new(['--debug']).execute!
      end

    end
  end
end
