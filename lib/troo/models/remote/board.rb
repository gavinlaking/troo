module Troo
  module Remote
    class Board
      include Virtus.model
      include Troo::RemoteModelHelpers

      attribute :id
      attribute :name
      attribute :desc
      attribute :descData
      attribute :closed,        Boolean
      attribute :idOrganization
      attribute :pinned
      attribute :url
      attribute :shortUrl
      attribute :prefs
      attribute :labelNames

      alias_method :desc_data,         :descData
      alias_method :id_organization,   :idOrganization
      alias_method :short_url,         :shortUrl
      alias_method :label_names,       :labelNames

      alias_method :external_board_id, :id
      alias_method :description,       :desc
    end
  end
end
