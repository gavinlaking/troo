guard :minitest do
  watch(%r{^test/(.*)_test\.rb})
  watch(%r{^lib/(.+)\.rb})               { |m| "test/lib/#{m[1]}_test.rb" }
  watch(%r{^test/test_helper\.rb})       { 'test' }
  watch(%r{^test/support/vcr_setup\.rb}) { 'test' }
end

guard :cucumber, :cli => '--format pretty --no-profile --tags ~@wip --tags ~@pending' do
  watch(%r{^features/(.+)\.feature$})             { |m| m[0] }
  watch(%r{^features/step_definitions/(.+)\.rb$}) { 'features' }
  watch(%r{^features/support/(.+)$})              { 'features' }
end
