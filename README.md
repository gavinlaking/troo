[![Code Climate](https://codeclimate.com/github/gavinlaking/troo.png)](https://codeclimate.com/github/gavinlaking/troo)

# Troo

CLI interface for Trello. Named after Trello's mascot 'Roo'.

## Commands

- Add board, list, card or comment.

        troo add [board|list|card|comment] <id>

- Remove all local data.

        troo cleanup

- Show the current configuration.

        troo config

- Set board, list or card to be default.

        troo default [board|list|card] <id>

- Describe available commands or one specific command

        troo help [COMMAND]

- Prepare to use Troo.

        troo init

- Move card with <card_id> to list with <list_id> optionally to another board with <board_id>.

        troo move <card_id> <list_id> (<board_id>)

- Refresh board, list or card with <id>.

        troo refresh [board|list|card] <id>

- Show all the boards or the board, list, card with <id>. Also, show all comments for card with <id>.

        troo show [boards|board|list|card|comments] <id>

- Get troo status.

        troo status

- Print the version.

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

1) Sign in to Trello in the normal way.

2) Create your developer key at Trello:

    https://trello.com/1/appKey/generate

3) Go to:

    https://trello.com/1/connect?key=your_key_here&name=troo&response_type=token&scope=read,write

4) Add your authentication tokens to the configuration file `.trooconf` in your home directory. (This file will be created for you the first time you run `troo init`)

5) Have fun, and tweet me @gavinlaking if you like it.

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

    cd ./test/support/fake_trello
    ruby ./server.rb

5) Have fun.

6) When done, kill the server, revert `/etc/hosts` and remove the forwarding.

    sudo ipfw del 100
    sudo ipfw del 101

## Contribute

1. Fork it, clone it
2. `bundle`
3. `rake`
4. Create your feature branch (`git checkout -b my-new-feature`)
5. Write some tests, write some code, have some fun
6. Commit your changes (`git commit -am 'Add some feature'`)
7. Push to the branch (`git push origin my-new-feature`)
8. Create new Pull Request

