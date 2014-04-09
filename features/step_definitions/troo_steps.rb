Given(/^the Trello API is stubbed with "(.*?)"$/) do |stub|
  VCR.insert_cassette(stub, allow_playback_repeats: true)
end

Then(/^the output should be the version number of troo$/) do
  !!(all_output.match(/#{Troo::VERSION}/))
end

Before do
  config = Troo::Configuration.load('config/trooconf.yml', 'test')
  Ohm.connect(db: config.database)
end

After do
  Ohm.redis.flushdb
  VCR.eject_cassette
end
