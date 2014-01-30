Given(/^the Trello API is stubbed with "(.*?)"$/) do |stub|
  send(stub.to_sym)
end

Then(/^the output should be the version number of troo$/) do
  !!(all_output.match(/#{Troo::VERSION}/))
end

Before do
  Ohm.connect(db: Troo.config.test_db)
end

After do
  Ohm.redis.flushdb
end
