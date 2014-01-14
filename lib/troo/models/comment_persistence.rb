module Troo
  class CommentPersistence
    class << self
      def for(resource, options = {})
        new(resource, options).persist
      end
    end

    def initialize(resource, options = {})
      @resource = resource
      @options = options
    end

    def persist
      return local   if local_identical?
      return updated if local_exists?
      return created
    end

    private
    attr_reader :resource, :options

    def created
      Troo::Comment.create(remote)
    end

    def updated
      local.update(remote) && local
    end

    def local_identical?
      return false unless local_exists?
      return false if local_data != remote
      true
    end

    def local_data
      local.external_attributes
    end

    def local_exists?
      !!local
    end

    def local
      @local ||= Troo::Comment.first(external_comment_id: resource.id)
    end

    def remote
      @remote ||= Troo::External::CommentAdaptor.adapt(resource)
    end
  end
end
