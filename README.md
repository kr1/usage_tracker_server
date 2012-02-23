Panmind Usage Tracker Server
----------------------------

What is it?
===========

An `EventMachine`-based server that opens an UDP socket and sends out received data to a database

Does it work?
=============

Yes, we are using it in production.

Deploying
=========

 * Install the gem on the target machine and run it with this command:

     $ usage_tracker [environment]

   If you run it into a Rails.root it will log and write pids in canonical dirs.

   or can be put under Upstart using the provided configuration file located in
   `config/usage_tracker_server_upstart.conf`. Check it out and modify it to suit your needs.

   The daemon logs to `usage_tracker_server.log` if the log directory exists and rotates its
   logs when receives the USR1 signal.

 * The daemon writes its pid into usage\_tracker\_server.pid

 * The daemon can be configured to work with couchdb or mongodb adapter. Look at the
   sample configuration file for hints.

 * If the daemon cannot start, e.g. because of unavailable database or listening
   address, it will print a diagnostic message to STDERR, log to usage\_tracker.log
   and exit with status of 1.

 * The daemon exits gracefully if it receives the INT or the TERM signals.

