require "bundler/gem_tasks"
require 'rake/testtask'

task :default => :test
Rake::TestTask.new do |t|
    t.libs << 'test'
    t.test_files = FileList['test/*_test.rb']
    t.verbose = true
end

desc 'update Metro UI CSS for git'
task :update do
  require 'metro/ui/convert'
  Metro::Ui::Convert.new.run
end
