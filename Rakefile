require "bundler/gem_tasks"
require "rake/testtask"

Rake::TestTask.new do |t|
  t.libs << 'lib/trlo'
  t.test_files = FileList["test/lib/trlo/*_test.rb",
                          "test/lib/trlo/external/*_test.rb",
                          "test/lib/trlo/models/*_test.rb"]
  t.verbose = true
end

task :default => :test

