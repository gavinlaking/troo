# Troo

CLI interface for Trello. Named after Trello's mascot 'Roo'.

## Features

- troo refresh
- troo refresh --lists
- troo refresh --cards
- troo cleanup
- troo version
- troo add board
- troo add board
- troo add card
- troo add comment
- troo add list
- troo current board
- troo current card
- troo current list
- troo show board
- troo show list
- troo show card
- troo move

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


## Todo

- Update features.
- Fix multitude of sins.
- Write cucumber integration tests.
- Consider caching.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

