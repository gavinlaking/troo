require "bundler/gem_tasks"
require "rake/testtask"
require 'cucumber'
require 'cucumber/rake/task'

if File.exist?(Dir.home + '/.trooconf')
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
else
  warn "\nConfiguration cannot be found, please run 'troo " \
       "init' or './bin/troo init' first.\n"
  exit(1)
end
