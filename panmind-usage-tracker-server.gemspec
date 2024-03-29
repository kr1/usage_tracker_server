# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run 'rake gemspec'
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  require 'yaml'
  YAML::ENGINE.yamler = 'syck'
  s.name = "panmind-usage-tracker-server"
  s.version = "1.1.5"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Christian Woerner", "Fabrizio Regini", "Marcello Barnaba"]
  s.date = "2012-02-24"
  s.description = "this software implements an EventMachine reactor which stores json-objects received via UDP in a database."
  s.email = "info@panmind.com"
  s.executables = ["usage_tracker_server"]
  s.extra_rdoc_files = [
    "README.md"
  ]
  s.files = [
    "README.md",
    "Rakefile",
    "VERSION",
    "bin/usage_tracker_server",
    "config/usage_tracker_server.yml.sample",
    "config/usage_tracker_server_upstart.conf",
    "lib/usage_tracker_server.rb",
    "lib/usage_tracker_server/adapter.rb",
    "lib/usage_tracker_server/adapters/couchdb.rb",
    "lib/usage_tracker_server/adapters/mongodb.rb",
    "lib/usage_tracker_server/log.rb",
    "lib/usage_tracker_server/reactor.rb",
    "lib/usage_tracker_server/runner.rb",
    "log/.placeholder",
    "panmind-usage-tracker-server.gemspec"
  ]
  s.homepage = "http://github.com/Panmind/usage_tracker_server"
  s.require_paths = ["lib"]
  s.summary = "server component for usage-tracker-middleware (Rack)"

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<eventmachine>, [">= 0"])
      s.add_runtime_dependency(%q<couchrest>, [">= 0"])
      s.add_runtime_dependency(%q<mongo>, [">= 0"])
      s.add_runtime_dependency(%q<bson>, [">= 0"])
      s.add_runtime_dependency(%q<bson_ext>, ["= 1.6.0"])
    else
      s.add_dependency(%q<eventmachine>, [">= 0"])
      s.add_dependency(%q<couchrest>, [">= 0"])
      s.add_dependency(%q<mongo>, [">= 0"])
      s.add_dependency(%q<bson>, [">= 0"])
      s.add_dependency(%q<bson_ext>, ["= 1.6.0"])
    end
  else
    s.add_dependency(%q<eventmachine>, [">= 0"])
    s.add_dependency(%q<couchrest>, [">= 0"])
    s.add_dependency(%q<mongo>, [">= 0"])
    s.add_dependency(%q<bson>, [">= 0"])
    s.add_dependency(%q<bson_ext>, ["= 1.6.0"])
  end
end

