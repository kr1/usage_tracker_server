require 'usage_tracker_server/adapters/couchdb'
require 'usage_tracker_server/adapters/mongodb'

module UsageTrackerServer
  class Adapter
    def self::new(settings)
      klass =
        case settings.adapter
          when 'couchdb'
            Adapters::Couchdb
          when 'mongodb'
            Adapters::Mongodb
        end
      klass::new(settings)
    end
  end
end
