# encoding: utf-8 
#
require 'rake'
require 'rake/rdoctask'

begin
  require 'jeweler'

  Jeweler::Tasks.new do |gemspec|
    gemspec.name        = 'panmind-usage-tracker-server'
    gemspec.summary     = 'server component for usage-tracker-middleware (Rack)'
    gemspec.description = 'this software implements an EventMachine reactor ' \
                          'which stores json-objects received via UDP in a database.'

    gemspec.authors     = ['Christian Woerner', 'Fabrizio Regini', 'Marcello Barnaba']
    gemspec.homepage    = 'http://github.com/Panmind/usage_tracker_server'
    gemspec.email       = 'info@panmind.com'

    gemspec.add_dependency('eventmachine')
    gemspec.add_dependency('couchrest')
    gemspec.add_dependency('mongo')
    gemspec.add_dependency('bson')
    gemspec.add_dependency('bson_ext')
  end
rescue LoadError
  puts 'Jeweler not available. Install it with: gem install jeweler'
end

desc 'Generate the rdoc'
Rake::RDocTask.new do |rdoc|
  rdoc.rdoc_files.add %w( README.md lib/**/*.rb )

  rdoc.main  = 'README.md'
  rdoc.title = 'Usage Tracker Server'
end
