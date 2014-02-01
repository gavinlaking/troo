Given(/^the Trello API is stubbed with "(.*?)"$/) do |stub|
  VCR.insert_cassette(stub)
end

Then(/^the output should be the version number of troo$/) do
  !!(all_output.match(/#{Troo::VERSION}/))
end

Before do
  Ohm.connect(db: Troo.config.test_db)
end

After do
  Ohm.redis.flushdb
  VCR.eject_cassette
end
