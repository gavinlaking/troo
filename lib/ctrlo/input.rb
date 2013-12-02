module Ctrlo
  class Input
    def initialize(id = nil)
      @id = id
    end

    def get
      system [ENV['EDITOR'], path].join(" ")
      input
    end

    private
    attr_reader :id

    def input
      File.open(path).readlines.join("\n")
    end

    def path
      @path ||= temporary_file.path
    end

    def temporary_file
      Tempfile.new(temporary_filename)
    end

    def temporary_filename
      Digest::MD5.hexdigest('#{id}#{Time.now.to_i}')
    end
  end
end

