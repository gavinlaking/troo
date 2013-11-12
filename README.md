# Trlo

CLI interface for Trello.

## Installation

Add this line to your application's Gemfile:

    gem 'trlo'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install trlo

## Usage

You will need user authentication tokens to access your Trello account.

1) Create your developer key at Trello:

    https://trello.com/1/appKey/generate

2) Go to

    https://trello.com/1/connect?key=your_key_here&name=trlo&response_type=token&scope=read,write


## Todo

- Write cucumber integration tests.
- Consider caching.

## Known Issues

- Between the time of retrieving boards, lists or cards, they could have changed state already (e.g. gone away) therefore your command will not work as expected.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

