Then(/^the output should be the version number of troo$/) do
  !!(all_output.match(/#{Troo::VERSION}/))
end
