require "bundler/gem_tasks"
require "rake/testtask"

Rake::TestTask.new do |t|
  t.libs << 'lib/ctrlo'
  t.test_files = FileList["test/lib/ctrlo/*_test.rb",
                          "test/lib/ctrlo/**/*_test.rb"]
  t.verbose = true
end

task :default => :test

