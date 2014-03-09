require "bundler/gem_tasks"
require "rake/testtask"
require 'cucumber'
require 'cucumber/rake/task'

Cucumber::Rake::Task.new(:cucumber) do |t|
  t.cucumber_opts = "features --format progress"
end

Rake::TestTask.new do |t|
  t.libs << 'lib/troo'
  t.test_files = FileList["test/lib/troo/*_test.rb",
                          "test/lib/troo/**/*_test.rb"]
  t.verbose = false
end

task :default => :test

Rake::Task['cucumber'].execute
