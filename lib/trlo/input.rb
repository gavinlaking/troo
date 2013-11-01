module Trlo
  class Input
    def self.get(id = nil)
      tempfile = Tempfile.new(Digest::MD5.hexdigest('#{id}#{Time.now.to_i}'))
      system [ENV['EDITOR'], tempfile.path].join(" ")
      input = File.open(tempfile.path).readlines
      tempfile.unlink
      input
    end
  end
end

