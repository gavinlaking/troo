module Troo
  class CommentPersistence
    include Persistence

    def initialize(resource, options = {})
      @resource = resource
      @options = options
    end

    private
    attr_reader :resource, :options

    def created
      Troo::Comment.create(remote)
    end

    def local
      @local ||= Troo::Comment.first(external_comment_id: resource.id)
    end

    def remote
      @remote ||= Troo::External::CommentAdaptor.adapt(resource)
    end
  end
end
