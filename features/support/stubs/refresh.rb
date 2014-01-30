module Stubs
  module Refresh
    def refresh_board_success
      stub_request(:get, url + "").with(body: "", headers: headers).
        to_return(body: fixture("add", "board_success"), status: 200, headers: {})
    end

    def refresh_card_success
      stub_request(:get, url + "").with(body: "", headers: headers).
        to_return(body: fixture("add", "board_success"), status: 200, headers: {})
    end

    def refresh_list_success
      stub_request(:get, url + "").with(body: "", headers: headers).
        to_return(body: fixture("add", "board_success"), status: 200, headers: {})
    end
  end
end
