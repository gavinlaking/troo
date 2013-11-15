require "bundler/gem_tasks"
require "rake/testtask"

Rake::TestTask.new do |t|
  t.libs << 'lib/trlo'

  # load all files except configuration
  t.test_files = FileList["test/lib/trlo/*_test.rb",
                          "test/lib/trlo/models/*_test.rb"].delete_if do |file|
    file =~ /configuration_test/
  end
  t.verbose = true
end

task :default => :test

