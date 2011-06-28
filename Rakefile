require 'rubygems'
require 'bundler/setup'
require 'appraisal'
require 'rake'
require 'rake/testtask'
require 'rdoc/task'
require 'rubygems/package_task'
require 'cucumber/rake/task'
require 'rspec/core/rake_task'
require 'yard'

desc 'Default: run the specs and features.'
task :default => [:cleanup, 'appraisal:install'] do
  system("rake -s appraisal spec cucumber;")
end

desc 'cleanup temporary files in tmp/ directory'
task :cleanup do
  FileUtils.rm_rf('tmp')
  FileUtils.mkdir('tmp')
end

desc 'Test the copycopter_client plugin.'
RSpec::Core::RakeTask.new do |t|
  t.rspec_opts = ['--color', "--format progress"]
  t.pattern = 'spec/copycopter_client/**/*_spec.rb'
end

desc "Run cucumber features"
Cucumber::Rake::Task.new do |t|
  t.cucumber_opts = ['--tags', '~@wip',
                     '--format', (ENV['CUCUMBER_FORMAT'] || 'progress')]
end

YARD::Rake::YardocTask.new do |t|
  t.files   = ['lib/**/*.rb']
end

eval("$specification = begin; #{IO.read('copycopter_client.gemspec')}; end")
Gem::PackageTask.new($specification) do |package|
  package.need_zip = true
  package.need_tar = true
end

gem_file = "pkg/#{$specification.name}-#{$specification.version}.gem"

desc "Build and install the latest gem"
task :install => :gem do
  sh("gem install --local #{gem_file}")
end

desc "Build and release the latest gem"
task :release => :gem do
  sh("gem push #{gem_file}")
end

