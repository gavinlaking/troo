module Stubs
  module Show
    def retrieve_board
      stub_request(:get, url + "").with(body: "", headers: headers).
        to_return(body: fixture("add", "board_success"), status: 200, headers: {})
    end

    def retrieve_card
      stub_request(:get, url + "").with(body: "", headers: headers).
        to_return(body: fixture("add", "board_success"), status: 200, headers: {})
    end

    def retrieve_comment
      stub_request(:get, url + "").with(body: "", headers: headers).
        to_return(body: fixture("add", "board_success"), status: 200, headers: {})
    end

    def retrieve_list
      stub_request(:get, url + "").with(body: "", headers: headers).
        to_return(body: fixture("add", "board_success"), status: 200, headers: {})
    end
  end
end
