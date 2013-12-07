module Ctrlo
  module Helpers
    def notify(message = nil)
      puts message
    end

    def error(message = nil)
      if message
        puts message
      else
        puts "No error message was given."
      end
    end
  end
end
