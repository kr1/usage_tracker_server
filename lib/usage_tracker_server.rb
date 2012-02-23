require 'rubygems'
require 'erb'
require 'yaml'
require 'pathname'
require 'ostruct'
require 'couchrest'
require 'usage_tracker_server/log'
require 'usage_tracker_server/adapter'

module UsageTrackerServer
  class << self
    # Memoizes settings from the ./config/usage_tracker_server.yml file,
    # relative from __FILE__ and searches for the "usage_tracker_server"
    # configuration block. Raises RuntimeError if it cannot find
    # the configuration.
    #
    def settings
      @settings ||= begin

        rc_file  = Pathname.new('.').join('config', 'usage_tracker_server.yml')
        settings = YAML.load(rc_file.read) if rc_file.exist?

        if settings == nil
          raise "Configuration missing."
        elsif settings.values_at(*%w(adapter database listen)).any?(&:nil?)
          raise "Incomplete configuration: please set the 'adapter', 'database' and 'listen' keys"
        end

        host, port = settings.delete('listen').split(':')

        if [host, port].any? {|x| x.strip.empty?}
          raise "Please specify where to listen as host:port"
        end

        settings['host'], settings['port'] = host, port.to_i

        settings['log_level'] ||= :warn
        log.level = settings['log_level']

        OpenStruct.new settings
      end
    end

    def database
      @database or raise "Not connected to the database"
    end

    def adapter
      @adapter or raise "Not connected to the database adapter"
    end

    # Connects to the configured CouchDB and memoizes the
    # CouchRest::Database connection into an instance variable
    # and calls +load_views!+
    #
    # Raises RuntimeError if the connection could not be established
    #
    def connect!
      @adapter = Adapter::new settings
      @database = @adapter.database
    end

    # Code to run inside EventMachine
    def run!
      host, port = UsageTrackerServer.settings.host, UsageTrackerServer.settings.port

      unless (1024..65535).include? port.to_i
        raise "Please set a listening port between 1024 and 65535"
      end

      EventMachine.open_datagram_socket host, port, Reactor
      log "Listening on #{host}:#{port} UDP"
      write_pid!
    end

    def write_pid!(pid = $$)
      dir = Pathname.new('.').join('tmp', 'pids')
      dir = Pathname.new(Dir.tmpdir) unless dir.directory?
      dir.join('usage_tracker_server.pid').open('w+') {|f| f.write(pid)}
    end

    def log(message = nil)
      @log ||= Log.new
      message ? @log.info(message) : @log
    end

    def raise(message)
      log.error message
      Kernel.raise Error, message
    end
  end

  class Error < StandardError; end
end
