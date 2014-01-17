require "bundler/gem_tasks"
require "rake/testtask"

Rake::TestTask.new do |t|
  t.libs << 'lib/troo'
  t.test_files = FileList["test/lib/troo/*_test.rb",
                          "test/lib/troo/**/*_test.rb"]
  t.verbose = false
end

task :default => :test

