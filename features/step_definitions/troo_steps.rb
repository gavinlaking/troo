Given(/^the Trello API is stubbed with "(.*?)"$/) do |stub|
  VCR.insert_cassette(stub)
end

Then(/^the output should be the version number of troo$/) do
  !!(all_output.match(/#{Troo::VERSION}/))
end

Before do
  Troo::Configuration.load('test/support/.trooconf', :test)
  Ohm.connect(db: Troo.configuration.database)
end

After do
  Ohm.redis.flushdb
  VCR.eject_cassette
end
