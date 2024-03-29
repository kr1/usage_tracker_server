#!/usr/bin/env ruby 

# This is the runner script where EventMachine gets 
# actually invocated.
# Behaviour is defined in the UsageTrackerServer::Reactor module 

$:<< File.expand_path(File.dirname(__FILE__) +  '/..')

require 'usage_tracker_server'
require 'usage_tracker_server/reactor'
require 'eventmachine'

module UsageTrackerServer

  connect!

  # Setup signal handlers
  #
  #  * INT, TERM: graceful exit
  #  * USR1     : rotate logs
  #
  def self.sigexit(sig)
    log "Received SIG#{sig}"
    EventMachine.stop_event_loop
  end

  trap('INT')  { sigexit 'INT'  }
  trap('TERM') { sigexit 'TERM' }
  trap('USR1') { log.rotate  }

  # Run the Event Loop
  #
  EventMachine.run do
    begin

      run! 

      $stderr.puts "Started, logging to #{log.path}"
      [$stdin, $stdout, $stderr].each {|io| io.reopen '/dev/null'}

    rescue Exception => e
      message = e.message == 'no datagram socket' ? "Unable to bind #{UsageTrackerServer.settings.host}:#{UsageTrackerServer.settings.port}" : e
      log.fatal message
      $stderr.puts message unless $stderr.closed?
      EventMachine.stop_event_loop
      exit 1
    end
  end

  # Goodbye!
  #
  log 'Exiting'
end 
  
