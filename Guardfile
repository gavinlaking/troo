guard :minitest do
  watch(%r{^test/(.*)_test\.rb})
  watch(%r{^lib/(.+)\.rb})               { |m| "test/lib/#{m[1]}_test.rb" }
  watch(%r{^test/test_helper\.rb})       { 'test' }
  watch(%r{^test/support/vcr_setup\.rb}) { 'test' }
end

guard :cucumber do
  watch(%r{^features/.+\.feature$})
  watch(%r{^features/support/.+$})       { 'features' }
  watch(%r{^features/step_definitions/(.+)_steps\.rb$}) do |m|
    Dir[File.join("**/#{m[1]}.feature")][0] || 'features'
  end
end
