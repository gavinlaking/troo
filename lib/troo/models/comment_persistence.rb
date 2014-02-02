module Troo
  class CommentPersistence < Resource
    private

    def created
      Troo::Comment.create(remote_data)
    end

    def local
      @local ||= Troo::Comment.first(external_comment_id: resource.id)
    end

    def remote_data
      @remote ||= Troo::External::CommentAdaptor.adapt(resource)
    end
  end
end
