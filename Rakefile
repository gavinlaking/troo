require "bundler/gem_tasks"
require "rake/testtask"

Rake::TestTask.new do |t|
  t.libs << 'lib/trlo'
  # load all files except configuration
  t.test_files = FileList["test/lib/trlo/test_*.rb"].delete_if do |file|
    file =~ /test_configuration/
  end
  t.verbose = true
end

task :default => :test

