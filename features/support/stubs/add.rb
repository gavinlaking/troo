module Stubs
  module Add
    def add_board_success
      stub_request(:post, url + "/boards").
        with(body: "name=Cuke%20Add%20Board", headers: headers).
        to_return(body: fixture("add", "board_success"), status: 200, headers: {})
    end

    def add_board_interactive_success
      stub_request(:post, url + "/boards").
        with(body: "name=My%20New%20Exciting%20Board", headers: headers).
        to_return(body: fixture("add", "board_interactive_success"), status: 200, headers: {})
    end

    def add_board_failure
      stub_request(:post, url + "/boards").
        with(body: "", headers: headers).
        to_return(body: fixture("add", "board_failure"), status: 200, headers: {})
    end

    def add_card_success
      stub_request(:post, url + "/cards").
        with(body: "", headers: headers).
        to_return(body: fixture("add", "card_success"), status: 200, headers: {})
    end

    def add_card_interactive_success
      stub_request(:post, url + "/cards").
        with(body: "name=My%20New%20Exciting%20Card", headers: headers).
        to_return(body: fixture("add", "card_interactive_success"), status: 200, headers: {})
    end

    def add_card_failure
      stub_request(:post, url + "/cards").
        with(body: "", headers: headers).
        to_return(body: fixture("add", "card_failure"), status: 200, headers: {})
    end

    def add_comment_success
      stub_request(:post, url + "/cards/526d8f19ddb279532e005259/actions/comments").
        with(body: "", headers: headers).
        to_return(body: fixture("add", "comment_success"), status: 200, headers: {})
    end

    def add_comment_interactive_success
      stub_request(:post, url + "/comments").
        with(body: "name=My%20New%20Exciting%20Comment", headers: headers).
        to_return(body: fixture("add", "comment_interactive_success"), status: 200, headers: {})
    end

    def add_comment_failure
      stub_request(:post, url + "/cards/526d8f19ddb279532e005259/actions/comments").
        with(body: "", headers: headers).
        to_return(body: fixture("add", "comment_failure"), status: 200, headers: {})
    end

    def add_list_success
      stub_request(:post, url + "/lists").
        with(body: "", headers: headers).
        to_return(body: fixture("add", "list_success"), status: 200, headers: {})
    end

    def add_list_interactive_success
      stub_request(:post, url + "/lists").
        with(body: "name=My%20New%20Exciting%20List", headers: headers).
        to_return(body: fixture("add", "list_interactive_success"), status: 200, headers: {})
    end

    def add_list_failure
      stub_request(:post, url + "/lists").
        with(body: "", headers: headers).
        to_return(body: fixture("add", "list_failure"), status: 200, headers: {})
    end
  end
end
