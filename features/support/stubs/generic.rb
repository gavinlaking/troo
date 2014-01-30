module Stubs
  module Generic
    def unauthenticated
      stub_request(:get, url + "").with(body: "", headers: headers).
        to_return(body: fixture("add", "card_failure"), status: 200, headers: {})
    end

    def trello_failure
      stub_request(:get, url + "").with(body: "", headers: headers).
        to_return(body: fixture("add", "card_failure"), status: 200, headers: {})
    end
  end
end
