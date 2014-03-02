[![Code Climate](https://codeclimate.com/github/gavinlaking/troo.png)](https://codeclimate.com/github/gavinlaking/troo)

# Troo

CLI interface for Trello. Named after Trello's mascot 'Roo'.

## Features

    troo refresh
    troo refresh --lists
    troo refresh --cards
    troo default board <board_id>
    troo default card <card_id>
    troo default list <list_id>
    troo add board <name>
    troo add card <list_id>
    troo add comment <card_id>
    troo add list <board_id>
    troo show boards
    troo show board (<board_id>)
    troo show list <list_id>
    troo show card <card_id>
    troo show comments <card_id>
    troo move <card_id> <list_id>
    troo cleanup
    troo version

## Requirements

- A Trello account with API key/secret.
- MacOSX/Linux (I've not tested with Windows, sorry.)
- Ruby 2.1.1 (>= 1.9.3 should be fine, developed mainly in 2.1.0 so far.)
- Redis.

## Installation

Add this line to your application's Gemfile:

    gem 'troo'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install troo

## Usage

You will need user authentication tokens to access your Trello account.

1) Create your developer key at Trello:

    https://trello.com/1/appKey/generate

2) Go to

    https://trello.com/1/connect?key=your_key_here&name=troo&response_type=token&scope=read,write

3) Add your authentication tokens to the configuration file `.trooconf` in your home directory. (This file will be created for you the first time you run `troo`)

4) Have fun, and tweet me @gavinlaking if you like it.

## Todo

- Fix multitude of sins.
- Write cucumber integration tests.
- Convert dates/times to Time.iso8601().

## Testing

I've put a simple fake server together so that I'm not hitting the Trello API continuously. You can activate and use this too.

1) Create own SSL certificate .crt and .key files:

    openssl req -new -x509 -nodes -out my-server.crt -keyout my-server.key

2) Forward all port 80 and port 443 requests to your local server.

    sudo ipfw add 100 fwd 127.0.0.1,8080 tcp from any to me 80
    sudo ipfw add 101 fwd 127.0.0.1,8443 tcp from any to me 443

3) Tell your machine to be `api.trello.com` by updating the `/etc/hosts` file:

    127.0.0.1 api.trello.com

4) Run `server.rb`:

    cd ./test/support/fake_server
    ruby ./server.rb

5) Have fun.

6) When done, kill the server, revert `/etc/hosts` and remove the forwarding.

    sudo ipfw del 100
    sudo ipfw del 101

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

